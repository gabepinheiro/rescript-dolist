let {
    queryOptions, 
    useQuery, 
    refetchOnWindowFocus,
    mutationOptions,
    useMutation
} = module(ReactQuery)

type requestResult = 
 | Data(array<TasksTypes.task>)
 | Loading
 | Error

type hookResult = {
    isCreating: bool,
    result: requestResult,
    taskName: string,
    handleChange: ReactEvent.Form.t => unit,
    handleCreateTask: ReactEvent.Mouse.t => unit
}

let apiURL = "http://localhost:3001"
let apiCodec = Jzon.array(TasksTypes.codec)

let tasksFetch = _ => {
    open Promise
    
    Fetch.fetch(`${apiURL}/tasks`, {"method": "GET"})
    ->then(response => response->Fetch.json)
    ->thenResolve(data => data->Jzon.decodeWith(apiCodec))
}

let createTask = (taskName) => {
    open Promise

    let newTask = {
        "name": taskName
        "completed": false,
        "createdAt": Js.Date.make()
    }

    Fetch.fetch(
        `${apiURL}/tasks`, 
        {
            "method": "POST",
            "body": Js.Json.stringifyAny(newTask),
            "headers": {
                "Content-Type": "application/json"
            }   
        }
    )->thenResolve(_ => ())
}

let useTasks = () => {
    let (taskName, setTaskName) = React.useState(_ => "")

    let result = useQuery(
        queryOptions(
            //
            ~queryKey=["tasks"],
            ~queryFn=tasksFetch,
            ~refetchOnWindowFocus=refetchOnWindowFocus(#bool(false)),
            ()
        )
    )

    let handleRefect = (_, _, _) => {
        result.refetch({
            throwOnError: false,
            cancelRefetch: false
        })
    }

    let { mutate: createTaskMutation, isLoading } = useMutation(
        mutationOptions(
            //
            ~onSuccess=handleRefect,
            ~mutationFn=createTask,
            ~mutationKey="new-task",
            (),
        ),
    )

    let handleCreateTask = _ => {
        createTaskMutation(. taskName, None)
    }

    let handleChange = event => {
        //event.target.value
        let target = ReactEvent.Form.target(event)
        setTaskName(_ => target["value"])
    }

    {
        isCreating: isLoading,
        result: switch result {
        | { isLoading: true } => Loading
        | { isError: true }
        | { data: Some(Error(_))} => Error
        | { data: Some(Ok(tasks)), isLoading: false, isError: false} => Data(tasks)
        | _ => Error
        },
        taskName,
        handleChange,
        handleCreateTask
    }
}
