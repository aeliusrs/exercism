package dna
import "errors"

type Histogram map[byte]int

type DNA []byte

func (d DNA) Counts() (Histogram, error) {
	h := Histogram{'A': 0, 'C': 0, 'G': 0, 'T': 0}
	for _, c := range d {
		_, valid := h[c]
		if !valid { return nil, errors.New("Nucleotid is not valid") }
		h[c]++
	}
	return h, nil
}
