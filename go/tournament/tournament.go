package tournament

import "io"
import "bufio"
import "strings"
import "fmt"
import "sort"


type Score struct {
    Name                 string
    MatchesPlayed        int
    Wins                 int
    Draws                int
    Losses               int
    Points               int
}

const header = "Team                           | MP |  W |  D |  L |  P\n"
const template = "%-31s| %2d | %2d | %2d | %2d | %2d\n"

func writeBoard(games map[string]Score, writer io.Writer) {
	var sortedScores []Score

	for _, score := range games { sortedScores = append(sortedScores, score) }

	sort.Slice(sortedScores, func(i, j int) bool {
		if sortedScores[i].Points == sortedScores[j].Points {
			return sortedScores[i].Name < sortedScores[j].Name
		}
		return sortedScores[i].Points > sortedScores[j].Points
	})

	fmt.Fprintf(writer, header)
	for _, score := range sortedScores {
		fmt.Fprintf(writer, template, score.Name, score.MatchesPlayed, score.Wins, score.Draws, score.Losses, score.Points)
	}
}

func computeGames(games [][]string) (map[string]Score, error) {
	scores := make(map[string]Score)

	for _, game := range games {
		team1 := game[0]
		team2 := game[1]
		result := game[2]

		score1, ok := scores[team1]

		if !ok {
			score1 = Score{Name: team1}
			scores[team1] = score1
		}

		score2, ok := scores[team2]

		if !ok {
			score2 = Score{Name: team2}
			scores[team2] = score2
		}

		switch result {
			case "win":
				score1.Wins++
				score1.MatchesPlayed++
				score1.Points += 3
				score2.Losses++
				score2.MatchesPlayed++
			case "draw":
				score1.Draws++
				score1.MatchesPlayed++
				score1.Points++
				score2.Draws++
				score2.MatchesPlayed++
				score2.Points++
			case "loss":
				score1.Losses++
				score1.MatchesPlayed++
				score2.Wins++
				score2.MatchesPlayed++
				score2.Points += 3
			default: return nil, fmt.Errorf("invalid result: %s", result)
		}
		score1.Points = 3 * score1.Wins + score1.Draws
		score2.Points = 3 * score2.Wins + score2.Draws

		scores[team1] = score1
		scores[team2] = score2
	}
	return scores, nil
}

func parseGames(reader io.Reader) ([][]string, error) {
	games := make([][]string, 0)
	bufReader := bufio.NewReader(reader)
	scanner := bufio.NewScanner(bufReader)

	for scanner.Scan() {
		line := scanner.Text()
		if len(line) == 0 || line[0] == '#' { continue }

		collect := strings.Split(line, ";")
		if len(collect) <= 2 {
			return nil, fmt.Errorf("bad format for line : %s", line)
		}
		games = append(games, collect)
	}
	return games, nil
}

func Tally(reader io.Reader, writer io.Writer) error {
	games, err := parseGames(reader)
	if err != nil { return err }

	board, err := computeGames(games)
	if err != nil { return err }

	writeBoard(board, writer)
	return nil
}

