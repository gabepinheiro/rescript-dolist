open Ancestor.Default
open Render

let {useTasks} = module(TasksHook)

let formatDate = value => value->Js.Date.fromString->DateFns.format("dd/MM/yy hh:mm")

module EmptyState = {
    @react.component
    let make = () => {
        <Box 
            display=[xs(#flex)] 
            flexDirection=[xs(#column)]
            alignItems=[xs(#center)]
            minH=[xs(40.0->#rem)]
            justifyContent=[xs(#center)]
        >
            <Base 
                tag=#img 
                width=[xs(200->#px)] 
                src=Assets.emptyState
                mb=[xs(3)]
            />

            <Typography 
                tag=#h1
                m=[xs(0)]
                mb=[xs(1)]
                fontSize=[xs(2.4->#rem)]
                fontWeight=[xs(#bold)]
                letterSpacing=[xs(-0.055->#em)]
                textAlign=[xs(#center)]
                color=[xs(Theme.Colors.white)]
            >
                {`Não há tarefas pendentes`->s}
            </Typography>

            <Typography
                m=[xs(0)]
                tag=#p 
                fontSize=[xs(1.8->#rem)]
                letterSpacing=[xs(-0.03->#em)]
                textAlign=[xs(#center)]
                color=[xs(Theme.Colors.grayLight)]
            >
                {`Adicione sua primeira tarefa utilizando o campo acima`->s}
            </Typography>
        </Box>
    }
}

module ErrorMessage = {
    @react.component
    let make = () => {
        <Box 
            display=[xs(#flex)] 
            flexDirection=[xs(#column)]
            alignItems=[xs(#center)]
            minH=[xs(40.0->#rem)]
            justifyContent=[xs(#center)]
        >
            <Typography 
                tag=#h1
                m=[xs(0)]
                mb=[xs(1)]
                fontSize=[xs(2.4->#rem)]
                fontWeight=[xs(#bold)]
                letterSpacing=[xs(-0.055->#em)]
                textAlign=[xs(#center)]
                color=[xs(Theme.Colors.white)]
            >
                {`Ocorreu algo inesperado`->s}
            </Typography>

            <Typography
                m=[xs(0)]
                tag=#p 
                fontSize=[xs(1.8->#rem)]
                letterSpacing=[xs(-0.03->#em)]
                textAlign=[xs(#center)]
                color=[xs(Theme.Colors.grayLight)]
            >
                {`Ocorreu um erro. Por favor, tente novamente.`->s}
            </Typography>
        </Box>
    }
}

module TaskItem = {
    @react.component
    let make = (~name, ~createdAt, ~completed, ~onCompletedTask=?) => {
        <Box 
            px=[xs(2)]
            py=[xs(2)]
            bgColor=[xs(Theme.Colors.grayDark)]
            borderRadius=[xs(1)]
            display=[xs(#flex)]
            justifyContent=[xs(#"space-between")]
            alignItems=[xs(#center)]

        >
            <Box>
                <Typography 
                    tag=#p
                    m=[xs(0)]
                    mb=[xs(1)]
                    fontSize=[xs(1.6->#rem)]
                    color=[xs(Theme.Colors.white)]
                    letterSpacing=[xs(-0.035->#em)]
                >
                    {name->s}
                </Typography>
                 <Typography 
                    tag=#p
                    m=[xs(0)]
                    fontSize=[xs(1.4->#rem)]
                    color=[xs(Theme.Colors.grayLight)]
                    letterSpacing=[xs(-0.035->#em)]
                >
                    {createdAt->s}
                </Typography>     
            </Box>
            <Checkbox checked=completed onChange=?onCompletedTask />
        </Box>
    }
}

module Spinner = {
    @react.component
    let make = () => {
        <Box
            minH=[xs(40.0->#rem)]
            width=[xs(100.0->#pct)]
            display=[xs(#flex)]
            alignItems=[xs(#center)]
            justifyContent=[xs(#center)]
        >   
            <Base 
                tag=#img src=Assets.spinnerSvg
                width=[xs(5.6->#rem)]
            />
        </Box>
    }
}

module NewTaskInput = {
    @react.component
    let make = (~isLoading=false, ~onChange=?, ~onSubmit=?, ~taskName) => {
        <Box>
            <Typography
                tag=#label
                letterSpacing=[xs(-0.035->#em)]
                fontWeight=[xs(#bold)]
                fontSize=[xs(2.4->#rem)]
                lineHeight=[xs(3.1->#rem)]
                color=[xs(Theme.Colors.white)]
                m=[xs(0)]
            >
                {`Nova Tarefa`->s}
            </Typography>
            <Box mt=[xs(2)] position=[xs(#relative)]>
                <Input 
                    value=taskName
                    placeholder="Compras da semana"
                    ?onChange 
                />
                <Box position=[xs(#absolute)] right=[xs(8->#px)] top=[xs(8->#px)]>
                    <Button 
                        loading=isLoading
                        disabled={taskName === "" || isLoading}
                        onClick=?onSubmit
                    >
                        `Adicionar`
                    </Button>
                </Box>
            </Box>
        </Box>
    }
}

@react.component
let make = () => {
    let { 
        result, 
        isCreating, 
        taskName, 
        handleChange, 
        handleCreateTask,
        handleCompleteTask
    } = useTasks()

    <Box display=[xs(#flex)] alignItems=[xs(#center)] flexDirection=[xs(#column)]>
        <Box 
            tag=#header
            display=[xs(#flex)]
            justifyContent=[xs(#center)]
            mb=[xs(3)]
        >
            <img src=Assets.logo />
        </Box>
        <Box 
            width=[xs(100.0->#pct)] 
            maxW=[xs(63.4->#rem)] 
            mt=[xs(10)]
            display=[xs(#flex)]
            flexDirection=[xs(#column)]
        >
            <NewTaskInput 
                onChange=handleChange
                onSubmit=handleCreateTask
                taskName=taskName
                isLoading=isCreating
            />

            {switch result { 
                | Loading => <Spinner />
                | Error => <ErrorMessage />
                | Data([]) => <EmptyState />
                | Data(tasks) => 
                    <Stack 
                        mt=[xs(5)]
                        spacing=[xs(2)] 
                        direction=[xs(#horizontal)]
                    >
                        {tasks->map((task, key) => {
                            let { name, completed, createdAt } = task

                            <TaskItem 
                                key 
                                name 
                                completed 
                                onCompletedTask={_ => handleCompleteTask(task)}
                                createdAt={createdAt->formatDate}
                            />
                        })}
                    </Stack>
                }
            }
        </Box>
    </Box>
}