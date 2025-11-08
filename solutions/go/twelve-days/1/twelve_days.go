package twelve

import "strings"

var days = []string{"first", "second", "third", "fourth", "fifth", "sixth",
                   "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"}

var gifts = []string{"a Partridge", "two Turtle Doves", "three French Hens",
                    "four Calling Birds", "five Gold Rings", "six Geese-a-Laying",
                    "seven Swans-a-Swimming", "eight Maids-a-Milking",
                    "nine Ladies Dancing", "ten Lords-a-Leaping",
                    "eleven Pipers Piping", "twelve Drummers Drumming"}

func Verse(day int) string {
	res := strings.Builder{}
    res.WriteString("On the ")
    res.WriteString(days[day-1])
    res.WriteString(" day of Christmas my true love gave to me:")
    for i := day-1; i >= 0; i-- {
        if i < day-1 {
            res.WriteString(",")
        }
        if day > 1 && i == 0 {
            res.WriteString(" and")
        }
        res.WriteString(" ")
        res.WriteString(gifts[i])
    }
    res.WriteString(" in a Pear Tree.")
    return res.String()
    
}

func Song() string {
	res := strings.Builder{}
    for day := 1; day <= 12; day++ {
        if day > 1 {
            res.WriteString("\n")
        }
        res.WriteString(Verse(day))
    }
    return res.String()
}
