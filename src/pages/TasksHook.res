let {queryOptions, useQuery, refetchOnWindowFocus} = module(ReactQuery)

let apiURL = "http://localhost:3001"
let apiCodec = Jzon.array(TasksTypes.codec)

let handleFetch = _ => {
    open Promise
    
    Fetch.fetch(`${apiURL}/tasks`, {"method": "GET"})
    ->then(response => response->Fetch.json)
    ->thenResolve(data => data->Jzon.decodeWith(apiCodec))
}

type requestResult = 
 | Data(array<TasksTypes.task>)
 | Loading
 | Error

let useTasks = () => {
    let result = useQuery(
        queryOptions(
            //
            ~queryKey=["tasks"],
            ~queryFn=handleFetch,
            ~refetchOnWindowFocus=refetchOnWindowFocus(#bool(false)),
            ()
        )
    )

    switch result {
    | { isLoading: true } => Loading
    | { isError: true }
    | { data: Some(Error(_))} => Error
    | { data: Some(Ok(tasks)), isLoading: false, isError: false} => Data(tasks)
    | _ => Error
    }
}
