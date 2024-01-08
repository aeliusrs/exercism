package strand

func translate(strand byte) byte {
	switch strand {
		case 'G': return 'C'
		case 'C': return 'G'
		case 'T': return 'A'
		case 'A': return 'U'
		default: return strand
	}
}

func ToRNA(dna string) string {
	acc := make([]byte, len(dna))

	for i := 0; i < len(dna); i++ {
		acc[i] = translate(dna[i])
	}
	return string(acc)
}
