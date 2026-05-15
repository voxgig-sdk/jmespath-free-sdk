package core

type JmespathFreeError struct {
	IsJmespathFreeError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewJmespathFreeError(code string, msg string, ctx *Context) *JmespathFreeError {
	return &JmespathFreeError{
		IsJmespathFreeError: true,
		Sdk:              "JmespathFree",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *JmespathFreeError) Error() string {
	return e.Msg
}
