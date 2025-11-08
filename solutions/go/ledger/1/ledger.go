package ledger

// Refactoring, list of changes:
//
// 1. Use Sprintf for generating ledger header.
// 2. Store ledger column names in a map.
// 3. Use append to make copy of entries instead of an explicit loop.
// 4. Replace hand-coded sort on entries with slices.SortFunc.
// 5. Remove concurrency, don't introduce it until you have an obvious performance problem.
// 6. Replace currency symbol logic with a table.
// 7. Simplify logic to check if currency is valid.
// 8. Remove unneccessary symbol currency check.
// 9. Refactor date parsing and checking in function parseDate.
// 10. Refactor description formatting in function fmtDescription.
// 11. Refactor amount formatting in function fmtAmount and fmtDecimal.
// 12. Refactor formatting of ledger entry.
// 13. Provide meaningful error messages.

import (
	"cmp"
	"fmt"
	"regexp"
	"slices"
	"strings"
)

type localeData struct {
	date    string
	desc    string
	chg     string
	dateFmt string
}

// ColNames contains the ledger column titles per locale.
// The date format use arguments 1=year, 2=month, 3=day
var locales = map[string]localeData{
	"en-US": localeData{"Date", "Description", "Change", "%[2]s/%[3]s/%[1]s"},
	"nl-NL": localeData{"Datum", "Omschrijving", "Verandering", "%[3]s-%[2]s-%[1]s"}}

// Currencies symbols
// Note: the original program logic allows for different symbosl per locale
// but doesn't implement any such difference. YAGNI.
var currencies = map[string]string{"EUR": "€", "USD": "$"}

var dateRe = regexp.MustCompile(`^(\d{4})-(\d{2})-(\d{2})$`)

type Entry struct {
	Date        string // "Y-m-d"
	Description string
	Change      int // in cents
}

func fmtDate(date, dateFmt string) (string, error) {
	ymd := dateRe.FindStringSubmatch(date)
	if ymd == nil {
		return "", fmt.Errorf("invalid date format: %s", date)
	}
	return fmt.Sprintf(dateFmt, ymd[1], ymd[2], ymd[3]), nil
}

func fmtDescription(desc string) string {
	if len(desc) > 25 {
		return fmt.Sprintf("%s...", desc[:22])
	}
	return fmt.Sprintf("%-25s", desc)
}

func fmtDecimal(number int, sep string) string {
	res := []string{}
	for {
		frac := number % 1000
		res = append(res, fmt.Sprintf("%d", frac))
		number /= 1000
		if number == 0 {
			break
		}
	}
	slices.Reverse(res)
	return strings.Join(res, sep)
}

func fmtAmount(cents int, currency, locale string) string {
	negative := false
	if cents < 0 {
		cents *= -1
		negative = true
	}
	frac := cents % 100
	main := cents / 100
	curSymbol := currencies[currency]

	res := ""

	switch locale {
	case "nl-NL":
		if negative {
			res = fmt.Sprintf("%s %s,%02d-", curSymbol, fmtDecimal(main, "."), frac)
		} else {
			res = fmt.Sprintf("%s %s,%02d ", curSymbol, fmtDecimal(main, "."), frac)
		}
	case "en-US":
		if negative {
			res = fmt.Sprintf("(%s%s.%02d)", curSymbol, fmtDecimal(main, ","), frac)
		} else {
			res = fmt.Sprintf("%s%s.%02d ", curSymbol, fmtDecimal(main, ","), frac)
		}
	}
	return res
}

func FormatLedger(currency string, locale string, entries []Entry) (string, error) {

	// Check currency is valid.
	if _, ok := currencies[currency]; !ok {
		return "", fmt.Errorf("unknown currency: %s", currency)
	}

	// Check locale is valid.
	if _, ok := locales[locale]; !ok {
		return "", fmt.Errorf("unknown locale: %s", locale)
	}

	// Copy the entry list to avoid mutating input.
	var entriesCopy []Entry
	entriesCopy = append(entriesCopy, entries...)

	// Sort the entry list by ascending Date, Description, and Change.
	slices.SortFunc(entriesCopy, func(a, b Entry) int {
		if dateCmp := strings.Compare(a.Date, b.Date); dateCmp != 0 {
			return dateCmp
		}
		if descCmp := strings.Compare(a.Description, b.Description); descCmp != 0 {
			return descCmp
		}
		return cmp.Compare(a.Change, b.Change)
	})

	colNames := locales[locale]
	lines := []string{
		fmt.Sprintf("%-10s | %-25s | %s\n", colNames.date, colNames.desc, colNames.chg)}

	for _, entry := range entriesCopy {
		date, err := fmtDate(entry.Date, locales[locale].dateFmt)
		if err != nil {
			return "", err
		}
		desc := fmtDescription(entry.Description)
		amount := fmtAmount(entry.Change, currency, locale)
		lines = append(lines, fmt.Sprintf("%10s | %s | %13s\n", date, desc, amount))
	}
	return strings.Join(lines, ""), nil
}
