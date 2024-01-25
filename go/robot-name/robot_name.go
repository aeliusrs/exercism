package robotname

import "math/rand"
import "time"
import "fmt"

type Robot struct { name string }

var random = rand.New(rand.NewSource(time.Now().UnixNano()))
var mem = map[string]bool{}
var limit = 676000 // 26 * 26 * 1000

func getName() string {
	return fmt.Sprintf("%c%c%03d",
		random.Intn(26)+'A', random.Intn(26)+'A', random.Intn(1000))
}

func (r *Robot) Name() (string, error) {
	if r.name != "" {
		return r.name, nil
	}

	if len(mem) >= limit {
		return "", fmt.Errorf("Max number of robot reached")
	}

	r.name = getName()
	for mem[r.name] { r.name = getName() }

	mem[r.name] = true
	return r.name, nil
}

func (r *Robot) Reset() {
	mem[r.name] = false
	r.name = ""
}
