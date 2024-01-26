package account

// sync.Mutex is a type that provides mutual exclusion locks.
// sync.Mutex provides two methods: Lock() and Unlock().
import "sync"

type Account struct {
	fund     int64
	active   bool
	mutex    *sync.Mutex
}

func Open(amount int64) *Account {
	if amount < 0 { return nil }

	return &Account{ fund: amount, active:true, mutex: &sync.Mutex{} }
}

func (a *Account) Balance() (int64, bool) {
	if !a.active { return 0, false } else { return a.fund, true}
}

func (a *Account) Deposit(amount int64) (int64, bool) {
	a.mutex.Lock()
	defer a.mutex.Unlock()

	if !a.active  || a.fund < -amount { return 0, false }

	a.fund += amount
	return a.fund, true
}

func (a *Account) Close() (int64, bool) {
	a.mutex.Lock()
	defer a.mutex.Unlock()

	if (*a).active == false { return 0, false }

	ret := a.fund
	a.active = false
	a.fund = 0
	return ret, true
}
