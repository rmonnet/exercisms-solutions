package grep

import (
    "regexp"
    "bufio"
    "os"
    "fmt"
)

type options struct {
    lineNumber bool
    filenameOnly bool
    caseInsensitive bool
    invertPattern bool
    matchEntireLine bool
}

func parseFlags(flags []string) options {
    res := options{}
	for _, flag := range flags {
        if flag == "-n" {
            res.lineNumber = true
        }
        if flag == "-l" {
            res.filenameOnly = true
        }
    	if flag == "-i" {
            res.caseInsensitive = true
        }
    	if flag == "-v" {
            res.invertPattern = true
        }
        if flag ==  "-x" {
            res.matchEntireLine = true
        }
    }
    return res
}

func grepFile(re *regexp.Regexp, opt options, filename string,
             prependFilename bool) []string {
    res := []string{}
    file, err := os.Open(filename)
    // Ignore files that can't be read.
    if err != nil {
        return res
    }
    defer file.Close()
    sc := bufio.NewScanner(file)
    lineNo := 0
    for sc.Scan() {
        line := sc.Text()
        lineNo++
        match := re.MatchString(line)
        if opt.invertPattern {
            match = ! match
        }
        if  match {
            if opt.lineNumber {
                line = fmt.Sprintf("%d:%s", lineNo, line)
            }
            if prependFilename {
                line = fmt.Sprintf("%s:%s", filename, line)
            }
            res = append(res, line)
        }
    }
    return res
}

func Search(pattern string, flags, files []string) []string {
    opt := parseFlags(flags)
    if opt.caseInsensitive {
        pattern = "(?i)" + pattern
    }
    if opt.matchEntireLine {
        pattern = "^" + pattern + "$"
    }
    fmt.Printf("pattern=%s, ci=%t, flags=%v", pattern, opt.caseInsensitive, flags)
	re := regexp.MustCompile(pattern)
    res := []string{}
    for _, filename := range files {
        out := grepFile(re, opt, filename, len(files) > 1)
    	if opt.filenameOnly {
            if len(out) != 0 {
                res = append(res, filename)
            }
        } else {
            res = append(res, out...)
        }
    }
	return res
}
