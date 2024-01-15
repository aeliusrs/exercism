package gigasecond

import "time"

const gigasecond = 1_000_000_000

func AddGigasecond(t time.Time) time.Time {
	t = t.Add(gigasecond * time.Second)
	return t
}
