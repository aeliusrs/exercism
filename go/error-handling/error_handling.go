package erratum

func Use(opener ResourceOpener, input string) (err error) {
	/*
		If the error is a transient error,
		the function calls the ResourceOpener function again,
		to get a new resource and error.
		This loop continues until a non-transient error is returned,
		or a valid resource is obtained.
	*/
	rs, err := opener()
	for ; err != nil; rs, err = opener()  {
		if _, ok := err.(TransientError); !ok { return err }
	}

	/*
		The recover function can be used to catch a panic 
		and resume normal execution of the program.
		It's call via a defer func(),
		to be sure to be call at the closing of the function.
	*/
	defer func() {
		if r := recover(); r != nil {
			if f, ok := r.(FrobError); ok {
				rs.Defrob(f.defrobTag)
			}
			err = r.(error)
		}
	}()

	// ensuring the opener will be close
	defer rs.Close()

	rs.Frob(input)
	return err
}
