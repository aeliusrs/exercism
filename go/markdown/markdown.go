package markdown

import (
	"fmt"
	"strings"
	"regexp"
)

// Render takes a markdown string and returns an HTML string
func Render(markdown string) string {
	// Split the markdown string into lines
	mds := strings.Split(markdown, "\n")

	// Initialize a flag to keep track of whether we're in a list or not
	lst := false

	// Loop over each line in the markdown string
	for i := range mds {
		// Replace double underscores with strong tags
		mds[i] = regexp.MustCompile(`__(.*?)__`).ReplaceAllString(mds[i], `<strong>$1</strong>`)

		// Replace single underscores with em tags
		mds[i] = regexp.MustCompile(`_(.*?)_`).ReplaceAllString(mds[i], `<em>$1</em>`)

		// Check if the line starts with an asterisk and a space
		if strings.HasPrefix(mds[i], "* ") {
			// Replace the asterisk and space with an li tag
			mds[i] = strings.Replace(mds[i], "* ", "<li>", 1) + "</li>"

			// If we're not already in a list, add a ul tag
			if !lst {
				mds[i] = "<ul>" + mds[i]
				lst = true
			}

			// Check if this is the last item in the list or if the next line isn't a list item
			if (i < len(mds) - 1 && !strings.HasPrefix(mds[i + 1], "* ")) ||
				i == len(mds) - 1 {
				// Close the ul tag
				mds[i] = mds[i] + "</ul>"
				lst = false
			}
			// Skip to the next line
			continue
		}

		// Check if the line starts with one to six hashes followed by a space
		hd := regexp.MustCompile("^(#{1,6})( )").FindStringIndex(mds[i])
		if len(hd) > 0 {
			// Replace the hashes and space with an h tag
			mds[i] = fmt.Sprintf("<h%d>", hd[1] - 1) + mds[i][hd[1]:] + fmt.Sprintf("</h%d>", hd[1] - 1)
			// Skip to the next line
			continue
		}

		// Wrap the line in a p tag
		mds[i] = "<p>" + mds[i] + "</p>"
	}

	// Join the lines together and return the resulting HTML string
	html := strings.Join(mds, "")
	return html
}
