styles {
    //styles for current system
    element "Person" {
        shape Person
        background #08427b
        color #ffffff
    }

    element "Person: External" {
        shape Person
        background #6C6477
        color #ffffff
    }

    element "Context: System" {
        shape RoundedBox
        background #08427b
        color white
    }

    element "NEW" {
        background #DAFAA2
        color black
    }

    element "MOD" {
        background #F49DC9
        color black
    }

    element "Context: External"{
        shape RoundedBox
        background silver
        color black
    }

    element "Container: Backend Service" {
        shape RoundedBox
        description true
        background #23A2D9
        color black
    }

    element "Container: Database" {
        shape Cylinder
        description true
        background #23A2D9
        color black
    }

    element "Container: Message Broker" {
        shape Pipe
        description true
        background #23A2D9
        color black
    }

    element "Container: Web GUI" {
        shape WebBrowser
        description true
        background #23A2D9
        color black
    }

    element "Container: Mobile GUI" {
        shape MobileDevicePortrait
        description true
        background #23A2D9
        color black
    }

    element "Component: Database" {
        shape Cylinder
        description true
        background #63BEF2
        color black
    }

    element "Component: Redis" {
        shape Cylinder
        description true
        background #BA141A
        color black
    }

    element "Component: Vault" {
        shape Cylinder
        description true
        background black
        color white
    }

    relationship "Relation: Synchronous" {
        color black
        style solid
        routing Direct
    }

    relationship "Relation: Asynchronous" {
        color black
        style dashed
        routing Direct
    }

    relationship "NEW" {
        color #147825
    }    

    relationship "MOD" {
        color #D95297
    }    
}