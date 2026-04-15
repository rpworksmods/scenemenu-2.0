> [!WARNING]
> # THIS RESOURCE IS DEPRECATED AND NO LONGER UPDATED OR SUPPORTED - FEEL FREE TO FORK OR IMPROVE THE CODE

> [!NOTE]
> # FIND MORE OF OUR RESOURCES AND ASSETS OVER AT [OUR STORE](https://rpworksmods.com/)

# Scene Menu 2.0
This resource allows players to easily and effectively manage the traffic around them. Place
barriers, cones and more to stop traffic in the area, and now even manage pedestrian traffic and
close off scenes.
With massive configuration support, you can easily add objects and configure them. This
resource has been tried and tested in nearly every FiveM server in one way or another these
days, and it’s the best option out there for traffic management. Whether you’re a police officer at
a collision with traffic blaring past, or you’re doing roadworks on Joshua Road, this menu will be
your best friend.
And with the brand new 2.0, it’s even easier and even more optimized than ever!

The original resource can be found (here)[https://github.com/rpworksmods/scenemenu/releases]

## HOW TO INSTALL
Step 1. Download the resource .zip via our website.
Step 2. Unpack the .zip file, and its contents.
Step 3. Move the contents of the .zip file into your ‘resources’ folder.
Step 4. Add the following line to your server.cfg AFTER the default resources.
ensure DH_Scenemenu
Step 5. Configure the resource to your liking, and play away

## CONFIGURATION

### ADDING PROPS
To add props to the spawnlist, navigate to the config.lua file and find ‘Config.Props’. In order to
add a prop to the list, copy a line already there and paste below, ensuring the curly brackets are
followed by a comma (Apart from the final entry).
{ Display = "Small Road Cone", Prop = "prop_roadcone02c", stopPeds = true}
Display = How the prop is displayed in the menu.
Prop = The prop spawn name
stopPeds = Whether this prop will make nearby peds stop and play an
animation.
(Click here to view a list of all props)[https://forge.plebmasters.de/objects]

### CHANGING ANIMATIONS
To change or add to the list of animations that a ped may play at an enabled prop, remain in the
config.lua file and find the ‘Config.Anims’ entry. In order to add a new animation to the list, copy
a line there by default and edit to match your needs. Once again, ensure that each closing curly
bracket is closed with a comma, bar the final one.
{Dict = "missfbi_s4mop", Anim = "guard_idle_a"},
Dict = Animation dictionary
Anim = Animation name/flag
(Click here to view a list of all animations)[https://forge.plebmasters.de/animations/amb@world_human_bum_wash@male@low@idle_a@idle_a?ped=A_F_Y_Beach_01]

## KNOWN BUGS
- After a player leaves the server, their props are unable to be removed.

## FAQ
- Q: Is it possible to change from a keybind to a / command?
- A: It absolutely is! Simply navigate to the main_menu.luafile, and locate line ‘131’. Replace lines
132 - 136 with the below code…
```lua
RegisterCommand("scenemenu", function(source, args, rawCommand)
if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
RageUI.Visible(SceneMenu, not RageUI.Visible(SceneMenu))
end
end, false)
```
- Q: How can I make it work with ESX permissions so only police can use it?
- A: Currently, the resource does not allow ESX integration.With some simple code, you can
indeed add some permissions for job-related access, however this hasn’t yet been implemented
