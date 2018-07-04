import macros
import sugar
import strutils

type
  Delegate[Proc] = seq[Proc]

{.push.}
{.experimental.}
# macro unpackVarargs*(callee: untyped; args: untyped): untyped =
#   result = newCall(callee)
#   for i in 0 ..< args.len:
#     result.add args[i]
proc `+=`[T](x: var Delegate[T]; y: T)=
  x.add( y)
proc `-=`[T](x: var Delegate[T]; y: T)=
  x.del( x.find y)
# macro add[T](x: var Delegate[T]; y: varargs[T]):untyped=
#   result = newStmtList()
#   for i in y:
#     result.add quote do:
#       system.add(`x`,`i`)
macro `()`[A](delegate: Delegate[A]; args: varargs[typed]):untyped =
  # var ex = newCall(getAst(delegate))
  # result = newStmtList()
  var call_ident = "call".ident
  var call = newCall(call_ident)
  for a in args:
    call.add a
  result = quote do:
    for `call_ident` in `delegate`:
      `call`
  hint repr result
  # var call = newCall(delegate.)
  # for call in delegate:
  #   unpackVarargs(call, args)
{.pop.}
# makeDelegate proc(), Event

var onEvent: Delegate[proc(k: string)]

onEvent += proc(k: string)= echo("1 Hi 1 on  " & k)
onEvent += proc(k: string)= echo("2 12312  " & k)
onEvent += proc(k: string)= echo("3 zxczxc " & k)
onEvent += proc(k: string)= echo("4 asdasddzxczxc " & k)
onEvent += proc(k: string)= echo("5 124523sdfsdzxczxc " & k)

onEvent("fasasdasd")




