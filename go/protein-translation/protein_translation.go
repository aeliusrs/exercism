package protein

import "errors"

var (
	ErrInvalidBase = errors.New("invalid RNA base")
	ErrStop        = errors.New("stop codon")
)

var protein = map[string]string{
	"AUG": "Methionine",
	"UUU": "Phenylalanine",
	"UUC": "Phenylalanine",
	"UUA": "Leucine",
	"UUG": "Leucine",
	"UCU": "Serine",
	"UCC": "Serine",
	"UCA": "Serine",
	"UCG": "Serine",
	"UAU": "Tyrosine",
	"UAC": "Tyrosine",
	"UGU": "Cysteine",
	"UGC": "Cysteine",
	"UGG": "Tryptophan",
	"UAA": "STOP",
	"UAG": "STOP",
	"UGA": "STOP",
}


func FromRNA(rna string) (acc []string, err error) {
	if len(rna) % 3 != 0 { return acc, ErrInvalidBase }

	for i := 0; i < len(rna); i += 3 {
		p, err := FromCodon(rna[i:(i + 3)])

		if errors.Is(err, ErrInvalidBase) { return nil, err}
		if errors.Is(err, ErrStop) { break }
		acc = append(acc, p)
	}
	return
}

func FromCodon(codon string) (string, error) {
		p, ok := protein[codon]

		if !ok || len(codon) % 3 != 0 { return "", ErrInvalidBase }
		if p == "STOP" { return "", ErrStop }
		return p, nil
}
