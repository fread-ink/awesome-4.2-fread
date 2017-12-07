This is a fork of the [awesome window manager](https://awesomewm.org/) version 4.2 modified to add XDamage support to the lua API. The changes are based on a patched version of awesome version 3.4.3 released by Amazon Inc / Lab126.

The original awesome README file has been moved to `README.md.orig`

# Usage

In your `/etc/xdg/awesome/rc.lua` file you can connect to the damage signals for client and screen like so:

```
client.connect_signal("damage", function(client, area)

  -- do stuff

end)


screen.connect_signal("damage", function(screen, area)

  -- do stuff

end)
```

The `area` object properties define the damaged area:

```
area.x
area.y
area.width
area.height
```

# ToDo

`xcb_damage_subtract` should probably only be called after all connected functions have been run and it might be useful if the signal function return values could determine whether or not `xcb_damage_subtract` gets called at all.

# Disclaimer

Kindle and Lab126 are registered trademarks of Amazon Inc. 

None of these organizations are in any way affiliated with fread nor this git project nor any of the authors of this project and neither fread nor this git project is in any way endorsed by these corporations.
