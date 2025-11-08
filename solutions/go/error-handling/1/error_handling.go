package erratum

import "fmt"

func Use(opener ResourceOpener, input string) (err error) {
    
    // Try to open the resource until we success or we get a non TransientError.
    var resource Resource
    for {
    	resource, err = opener()
        if err == nil {
            break
        }
        switch e := err.(type) {
        case TransientError: err = nil
        default: return e
        }
    }
    defer resource.Close()

    // Handle panic from the Frob() call.
    defer func() {
        if r := recover(); r != nil {
            switch e := r.(type) {
            case FrobError:
                resource.Defrob(e.defrobTag)
                err = e.inner
            case error:
                err = e
            default:
                err = fmt.Errorf("panic'ed calling Frob: %v", r)
            }
        }
    }()
    
    resource.Frob(input)

    return
}
