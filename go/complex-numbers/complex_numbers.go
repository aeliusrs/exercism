package complexnumbers

import "math"

type Number struct { num, img float64 }

func (n Number) Real() float64 { return n.num }

func (n Number) Imaginary() float64 { return n.img }

func (n1 Number) Add(n2 Number) Number {
	return Number {
		num: n1.num + n2.num,
		img: n1.img + n2.img,
	}
}

func (n1 Number) Subtract(n2 Number) Number {
	return Number {
		num: n1.num - n2.num,
		img: n1.img - n2.img,
	}
}

func (n1 Number) Multiply(n2 Number) Number {
	return Number{
		num: n1.num * n2.num - n1.img * n2.img,
		img: n1.num * n2.img + n1.img * n2.num,
	}
}

func (n Number) Times(factor float64) Number {
	return n.Multiply(Number{factor, 0})
}

func (n1 Number) Divide(n2 Number) Number {
	d := n2.num * n2.num + n2.img * n2.img

	return Number{
		num: (n1.num * n2.num + n1.img * n2.img) / d,
		img: (n1.img * n2.num - n1.num * n2.img) / d,
	}
}

func (n Number) Conjugate() Number {
	return Number {
		num: n.num,
		img: -n.img,
	}
}

func (n Number) Abs() float64 {
	return math.Sqrt(n.num * n.num + n.img * n.img)
}

func (n Number) Exp() Number {
	i := math.Exp(n.num)

	return Number{
		num: i * math.Cos(n.img),
		img: i * math.Sin(n.img),
	}
}
