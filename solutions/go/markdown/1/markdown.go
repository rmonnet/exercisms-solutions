package markdown

// List of refactoring:
//
// 1. Change the main loop to a classic loop (still increment pos in loop for skipping).
// 2. Use regexp to substitute strong and emphasis (safer).
// 3. Use Builder to generate output (more efficient).
// 4. Replace if statement with a switch for processing of next letter.
// 5. Scan the text line by line (Markdown syntax is line oriented).

import (
	"bufio"
	"fmt"
	"regexp"
	"strings"
)

var strongRe = regexp.MustCompile(`(?U)__(.+)__`)

var emRe = regexp.MustCompile(`(?U)_(.+)_`)

var headerRe = regexp.MustCompile(`^(#+) (.*)$`)

var listRe = regexp.MustCompile(`^\* (.*)$`)

// Render translates markdown to HTML
func Render(markdown string) string {

	markdown = strongRe.ReplaceAllString(markdown, "<strong>${1}</strong>")
	markdown = emRe.ReplaceAllString(markdown, "<em>${1}</em>")

	html := &strings.Builder{}
	sc := bufio.NewScanner(strings.NewReader(markdown))
	inPara := false
	inList := false

	for sc.Scan() {
		line := sc.Text()

		if hd := headerRe.FindStringSubmatch(line); hd != nil {
			if inPara {
				inPara = false
				fmt.Fprintf(html, "</p>")
			}
			level := len(hd[1])
			if level < 7 {
				fmt.Fprintf(html, "<h%d>%s</h%d>", level, hd[2], level)
			} else {
				// Anything above level 7 is not considered a header.
				fmt.Fprintf(html, "<p>%s %s</p>", hd[1], hd[2])
			}
			continue
		}
		if li := listRe.FindStringSubmatch(line); li != nil {
			if inPara {
				inPara = false
				fmt.Fprintf(html, "</p>")
			}
			if !inList {
				fmt.Fprintf(html, "<ul>")
				inList = true
			}
			fmt.Fprintf(html, "<li>%s</li>", li[1])
			continue
		}
		if inList {
			// Found the end of the list but there is more lines after that.
			inList = false
			fmt.Fprintf(html, "</ul>")
		}
		if !inPara {
			inPara = true
			fmt.Fprintf(html, "<p>")
		}
		fmt.Fprint(html, line)
	}

	// The list ends the markdown fragment.
	if inList {
		fmt.Fprintf(html, "</ul>")
	}
	if inPara {
		fmt.Fprintf(html, "</p>")
	}

	return html.String()
}
