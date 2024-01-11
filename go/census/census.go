// Package census simulates a system used to collect census data.
package census

// Resident represents a resident in this city.
type Resident struct {
	Name    string
	Age     int
	Address map[string]string
}

// NewResident registers a new resident in this city.
func NewResident(name string, age int, address map[string]string) *Resident {
	return &Resident{Name: name, Age: age, Address: address}
}

// HasRequiredInfo determines if a given resident has all of the required information.
func (r *Resident) HasRequiredInfo() bool {
	return r.Name != "" && r.Address != nil && r.Address["street"] != ""
}

// Delete deletes a resident's information.
func (r *Resident) Delete() {
	*r = *NewResident("", 0, nil)
}

// Count counts all residents that have provided the required information.
func Count(residents []*Resident) (sum int) {
	for _, r := range residents { if r.HasRequiredInfo() { sum ++ } }
	return
}
