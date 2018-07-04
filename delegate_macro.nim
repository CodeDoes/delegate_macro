import macros
import sugar

type
  Delegate[Proc: proc] = seq[Proc]

{.push.}
{.experimental.}
macro unpackVarargs*(callee: untyped; args: untyped): untyped =
  result = newCall(callee)
  for i in 0 ..< args.len:
    result.add args[i]
proc `+=`[T](x: var Delegate[T]; y: T)=
  x.add y
proc `-=`[T](x: var Delegate[T]; y: T)=
  x.del x.find y
macro add[T](x: var Delegate[T]; y: varargs[T]):untyped=
  result = newStmtList()
  for i in y:
    result.add quote do:
      system.add(`x`,`i`)
macro `()`[A](delegate: Delegate[A]; args: varargs):untyped =
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

var onEvent: Delegate[proc()]

onEvent += proc()= echo "1 Hi 1 one"
onEvent += proc()= echo "2 123122"

onEvent += 
  proc()= 
    echo("3 zxczxc")
onEvent += 
  proc()= 
    echo("4 asdasddzxczxc")
onEvent += 
  proc()= 
    echo("5 124523sdfsdzxczxc")

onEvent()




