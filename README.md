<p align="center">
  <img src="https://user-images.githubusercontent.com/45916622/181322541-230809a1-6997-46f5-9392-b4b6a94e88b9.png" width="256">
</p>

## What is Barden Roblox Library?

Barden Roblox Library is library software developed for use by the developers in the team.
It is used by Obyvante(me) to develop Roblox games in the past. It has unique and interesting ideas inside as a Roblox library.


## Getting started

### Building

To start using this library, simply clone this repository to your local machine. Now you can build your project inside `Project` folders. If you need some outside libraries, you can put in inside `Library` folders. That's all!


## Library

### Services

You can import/require services by using `Library`. The way is same for both client and server.

#### Example Import
```lua
local Library = require(game.ReplicatedStorage.Library.Library)
local StringService = Library.getService("StringService")
```

### Register your service!

You can register your service and use as like other services.

#### Example
```lua
Library.saveService(game.ReplicatedStorage.Project.Example.ExampleService)
local ExampleService = Library.getService("ExampleService")
```


### Client Callback Service

With this system, you can send a specific request to the client and wait for a response. The good thing about this system is it handles everything in the background, you do not have to deal with a timeout, event, wrong callback response, etc.

#### Example of Client Callback Service

#### Client
```lua

-- Creating a callback for 'ExampleEvent' with 10 seconds timeout duration. If we don't get the response in 10 seconds, it'll be failed(not success/throw error).
local success, result = pcall(function() ClientPlayer.update(ClientCallbackService.handle("ExampleEvent", 10)) end)

-- If it is not successful(timeout), we can do our coding here like kicking player if we couldn't get answer back from the server.
if not success then
  print("Couldn't get response from the server!")
  return
end

print(result)
```

#### Server
```lua
ExampleEvent.OnServerEvent:Connect(function(player)
  ExampleEvent:FireClient(player, "Hello from the server!")
end)
```

### Event Service

Event service simply helps you to find and import your events easier. In order to use this service, you must use the `events` folder in the project hierarchy.

#### Example of Event Service

```lua
-- It supports dot notation for folder hierarchy.
local ExampleEvent = EventService.get("Examples.ExampleEvent")
```

### HTTP Service

HTTP service helps you to handle and manage HTTP requests easier.

#### Example of HTTP Service (GET)

```lua
local response = HTTPService.GET("https://myendpoint.com/api/v1/books/", { ["my-custom-metadata"] = "Hello from the Roblox server!" })
-- If fetching data was not successfully, no need to continue.
if not response.Success then
  error("Couldn't get data from the backend! [1]")
end

local json = HTTPService.decodeJson(response.Body)
-- If backend response is not positive, no need to continue
if not json.success then
  error("Couldn't get data from the backend! [2] -> " .. json.error)
end

print(json)
```

#### Example of HTTP Service (POST)

```lua
local book_to_save_json = HTTPService.encodeJson({
  title: "Development",
  author: "Obyvante"
})
local response = HTTPService.POST("https://myendpoint.com/api/v1/books/", book_to_save_json, { ["key"] = "my-super-secret-key" })
-- If sending data was not successfully, no need to continue.
if not response.Success then
  error("Couldn't post data to the backend! [1]")
end

local json = HTTPService.decodeJson(response.Body)
-- If backend response is not positive, no need to continue
if not json.success then
  error("Couldn't post data to the backend! [2] -> " .. json.error)
end

print(json)
```

### Signal Service

Signal is a simple event binder service to prevent memory leaks and improve performance. Some of other public Roblox libraries have similar service.

#### Example of Signal Service

```lua
local example_event_signal = SignalService.create("ExampleEvent")

example_event_signal:connect(function(player)
  print("signal event response")
end)

ExampleEvent.OnServerEvent:Connect(function(player)
  signal_player_join:fire(player)
end)
```

### Spam Service

With this system, it is so much easier to handle any kind of spams including `RemoteEvent`.

#### Example of Spam Service

```lua
ExampleEvent.OnServerEvent:Connect(function(player)
  -- Creates a spam handler for `example_event` id(unique). It checks if `ExampleEvent` has fired more than 3 times in 10 seconds. If so, it'll return `true`.
  local is_spamming = SpamService.handle("example_event", 10, 3)
  player:Kick("Kicked, Reason: Spamming")
end)
```

### Task Service

Task service is one of the most important services in the library. It helps you a lot for async, scheduling, delaying, and so on.

#### Example of Task Service (1)

```lua
-- Creates a delayed task that runs after 10 seconds.
TaskService.createDelayed(10, function(_task)
  print("Hey!")
end):run()
```

#### Example of Task Service (2)

```lua
-- Creates a repeating task that runs every 10 seconds.
TaskService.createRepeating(1, function(_task)
  print("Elapsed time: " .. _task:getElapsedTime())
end):run()
```

#### Example of Task Service (3)

```lua
-- Creates a repeating task that runs every 30 seconds.
TaskService.createRepeating(30, function(_task)
  -- Your code here.
end):onError(function(_task, error)
  print("There is an error for a task" .. _task:getId() .. "! -> " .. error)
end):run()
```

#### Example of Task Service (4)

```lua
-- Creates a repeating task that runs every 1 seconds.
TaskService.createRepeating(1, function(_task)
  if task:getElapsedTime() == 5 then
    _task:cancel()
  end
end):onCancel(function(_task)
  print("task done!")
end):run()
```

### Templates

Templates are standalone and creatable objects. It does not work like services instead it assumes you are going to create a new object based on the target template.
You can import/require templates by using `Library`. The way is same for both client and server.

#### Example Import
```lua
local Library = require(game.ReplicatedStorage.Library.Library)
local Metadata = Library.getTemplate("Metadata")
```

### Register your template!

You can register your template and use as like other templates.

#### Example
```lua
Library.saveTemplate(game.ReplicatedStorage.Project.Example.ExampleTemplate)
local ExampleTemplate = Library.getTemplate("ExampleTemplate")
```

### Event Binder Template

Event binder allows you to create multiple event handlers in one object. You can use it as a class member to store events.

#### Example of Event Binder Template
```lua
local event_binder = EventBinder.new(self) -- You can declare parent object or make it empty if you do not have any.

event_binder:bind(ExampleEvent.OnServerEvent, {
  Name = "click", -- Unique event name.
  Consumer = function(_binder, _event) -- Event consumer.
    print("Executed!")
  end
})
```

### Metadata Template

You can create a metadata object and store your any kind of objects there. It seems like a table but it has unique features like expirable keys, async catch, error handling, getters and setters.

#### Example of Metadata Template
```lua
local metadata = Metadata.new()

metadata.set("key", "value")
metadata.set(1, true)
metadata.set({name: "test"}, "object value")

-- Creates a metadata object which will expire after 10 seconds.
metadata.set("expirable-key", "my value", 10, function(_metadata)
  print("key expired! -> " .. _metadata.has("expirable-key"))
end)
})
```

### Interfaces

Barden Roblox Library's interface library has a structure never seen before. It makes your job easier in many ways. It is the first pixel-rate supported interface library in Roblox. All your designs can be made on Figma and easily transferred to Roblox. Although many architectures are designed for Figma, people who have figured out their logic can easily use Figma without using it.

### How does it work?

When you want to create an interface, you first open Figma then create a `Frame`. This frame will be our `Viewport` screen. With this feature, our interfaces even can support 4K screens! You start building your interface inside of the frame! The thins you should be aware of, the library assume you are using `Frame`s for parented elements. For example, in the main frame, you created a button shape and want to add text named "Click me!". Since you have an element inside of another element, you should create that button as `Frame` object.

### Let's make our first interface!

We are going to build a simple interface that has base interface, text and a button.

#### Step 1

Open empty Figma project, create a `Frame` with the viewport you want to build on.

![image](https://user-images.githubusercontent.com/45916622/181427311-972d33dd-5095-4245-bdae-32154b8d8066.png)


#### Step 2

Create interface hierarchy.

![image](https://user-images.githubusercontent.com/45916622/181428092-ef54c3c1-e0fc-40d1-98ea-0ad30b38f168.png)

#### Step 3 (Optional)

Import PNG files if you have any. (e.g. if base component has custom effects, you must import it to use as `ImageFrame` in Roblox.)

#### Step 4 

Let's code!

```lua
-- Creates interface. `Vector2` represents our viewport(Main frame) in Figma(which is 1920x1080).
local interface = InterfaceService.createScreen("example-interface", Vector2.new(1920, 1080), 999)

-- Base panel.
local base = interface:addElement({
    Name = "base",
    Type = "Frame",
    Properties = {
        Custom = {
            Position = Vector2.new(600, 180), -- Position inside of the main frame in Figma.
            Size = Vector2.new(720, 720) -- Element size in Figma.
        },

        AnchorPoint = Vector2.new(0.5, 0.5), -- Roblox's default behaviour.
        BorderSizePixel = 0, -- Roblox's default behaviour.
        BackgroundTransparency = 0, -- Roblox's default behaviour.
        BackgroundColor3 = Color3.fromRGB(0, 255, 102) -- Roblox's default behaviour.
    },

    BuildWith = {
        "AspectRatio" -- If you are using `Custom`(pixel-based) interface and want to use `AspectRatio` feature of Roblox, you must use `BuildWith` like here.
    }
})

-- Creates welcome text.
panel:addElement({
    Name = "text",
    Type = "TextLabel",
    Properties = {
        Custom = {
            Position = Vector2.new(0, 157),
            Size = Vector2.new(720, 116),
            FontSize = 150 -- It supports infinite font size. Roblox's maximum font size is 100 but not here ;)
        },

        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        
        RichText = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = "DenkOne",
        Text = "Hello, it is an example interface!",
    }
})

-- Creates button.
local button = panel:addElement({
    Name = "button",
    Type = "ImageLabel",
    Properties = {
        Custom = {
            Position = Vector2.new(0, 157),
            Size = Vector2.new(550, 113)
        },

        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ImageTransparency = 0,

        Image = "rbxassetid://uploaded_png_roblox_id"
    },

    Events = { -- You can bind events to interface elements!
        {
            Name = "click", -- Unique event name.
            Event = "InputBegan", -- Event type(Roblox)
            Consumer = function(_binder, _event) -- Event consumer.
                -- It checks if the element is clicked by player. It supports mobile, pc and xbox by default. So you do not have to worry how to handle clicks for about other platforms.
                if not InterfaceService.isClicked(_event.UserInputType, _event.UserInputState) then return end

                print("button clicked!")
            end
        }
    }
})

-- Button text.
button:addElement({ -- If the interface element has parent, you should use `parent:addElement` to add element. 
    Name = "title",
    Type = "TextLabel",
    Properties = {
        Custom = {
            Position = Vector2.new(171, 28),
            Size = Vector2.new(208, 58),
            FontSize = 100
        },
    
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
            
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = "DenkOne",
        Text = "Click me!",
    }
})
```
