open Ancestor.Default
open Render

@module("../assets/logo.svg")  external logo: string = "default"
@module("../assets/empty-state.svg")  external emptyState: string = "default"

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
                src=emptyState
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

module TaskItem = {
    @react.component
    let make = (~name, ~createdAt, ~completed) => {
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
            <Checkbox checked=completed />
        </Box>
    }
}

module NewTaskInput = {
    @react.component
    let make = () => {
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
                <Input placeholder="Compras da semana" />
                <Box position=[xs(#absolute)] right=[xs(8->#px)] top=[xs(8->#px)]>
                    <Button>`Adicionar`</Button>
                </Box>
            </Box>
        </Box>
    }
}

@react.component
let make = () => {
    <Box display=[xs(#flex)] alignItems=[xs(#center)] flexDirection=[xs(#column)]>
        <Box 
            tag=#header
            display=[xs(#flex)]
            justifyContent=[xs(#center)]
            mb=[xs(3)]
        >
            <img src=logo />
        </Box>
        <Box 
            width=[xs(100.0->#pct)] 
            maxW=[xs(63.4->#rem)] 
            mt=[xs(10)]
            display=[xs(#flex)]
            flexDirection=[xs(#column)]
        >
            <NewTaskInput />

            <EmptyState />

            <Stack 
                mt=[xs(5)]
                spacing=[xs(2)] 
                direction=[xs(#horizontal)]
            >
                <TaskItem 
                    name="Lorem ipsum dolor sit amet"
                    createdAt="11/10/2021 às 19h53m"
                    completed=true
                />
                 <TaskItem 
                    name="Lorem ipsum dolor sit amet"
                    createdAt="11/10/2021 às 19h53m"
                    completed=true
                />
                 <TaskItem 
                    name="Lorem ipsum dolor sit amet"
                    createdAt="11/10/2021 às 19h53m"
                    completed=true
                />
                 <TaskItem 
                    name="Lorem ipsum dolor sit amet"
                    createdAt="11/10/2021 às 19h53m"
                    completed=true
                />
            </Stack>
        </Box>
    </Box>
}