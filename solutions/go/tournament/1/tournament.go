package tournament

import (
    "io"
    "bufio"
    "regexp"
    "errors"
    "fmt"
    "sort"
)

// GameRe is a regular expression parsing one line of input `<team1 name>;<team2 name>;<result>` where result is one of win, loss, draw.
var gameRe = regexp.MustCompile(`^(\w[\w\s]*);(\w[\w\s]*);(win|draw|loss)$`)

// CommentRe is a regular expression matching a comment line in the input
var commentRe = regexp.MustCompile(`^#`)

// Stats collects the statistics for a team.
type stats struct {
    wins int
    draws int
    losses int
}

// Points computes the number of points a team has (3 for win, 1 for draw, 0 for loss).
func (s stats) points() int {
    return 3 * s.wins + s.draws
}

// Played computes the number of games played by a team.
func (s stats) played() int {
    return s.wins + s.draws + s.losses
}

// Tournament collects the statistics of each team in a tournament.
type tournament map[string]*stats

// TallyGame tallies one game and update the teams statistics in the tournament.
func (t tournament) tallyGame(team1, team2, result string) {
    s1, ok := t[team1]
    if !ok {
        s1 = &stats{}
        t[team1] = s1
    }
    s2, ok := t[team2]
    if !ok {
        s2 = &stats{}
        t[team2] = s2
    }
    switch result {
        case "win":
        	s1.wins += 1
        	s2.losses += 1
        case "loss":
        	s1.losses += 1
        	s2.wins += 1
        case "draw":
        	s1.draws += 1
        	s2.draws += 1
    }
}

// Teams return the list of teams involved in the tournament, sorted by
// winner to loser. In case of tie, the team names are sorted in alphabetical order.
func (t tournament) teams() []string {
	res := make([]string, 0, len(t))
    for team := range t {
        res = append(res, team)
    }
    // Sort by descending points. If points are tied, sort by ascending team names.
    descPoint := func(i, j int) bool {
                         team1 := res[i]
                         team2 := res[j]
                         points1 := t[team1].points()
                         points2 := t[team2].points()
                         if points1 == points2 {
                             return team1 < team2
                         } else {
                             return points1 > points2
                         }
                    }
    sort.Slice(res, descPoint)
    return res
}

// Print generates a table showing the results of the tournament.
func (t tournament) Print(w io.Writer) {
	fmt.Fprintf(w, "Team                           | MP |  W |  D |  L |  P\n")
    for _, team := range t.teams() {
        results := t[team]
        fmt.Fprintf(w, "%-30s | %2d | %2d | %2d | %2d | %2d\n",
                   team, results.played(), results.wins, results.draws,
                   results.losses, results.points())
    }
}

// Tally reads the game results and generate a tournament result table.
func Tally(reader io.Reader, writer io.Writer) error {
	scanner := bufio.NewScanner(reader)
    games := make(tournament)
    for scanner.Scan() {
        line := scanner.Text()
        if len(line) == 0 || commentRe.MatchString(line) {
            continue
        }
        game := gameRe.FindStringSubmatch(scanner.Text())
        if game == nil || len(game) != 4 {
            return errors.New("Invalid input line")
        }
        games.tallyGame(game[1], game[2], game[3])
    }
    games.Print(writer)
    return scanner.Err()
}
