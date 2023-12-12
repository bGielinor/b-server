permission_handler:
  type: world
  debug: false
  events:
    on player receives commands:
      - define commands <context.commands.filter[contains_text[<&co>].not].exclude[<script.data_key[data.command_sets.blacklist]>]>
      # these are just shit junk commands
      - define commands <[commands].exclude[<script.parsed_key[data.command_sets.oddball]>]>


      - define allowed_commands <list>
      - foreach <[commands]> as:command:
        #                                                                 ( obviously this is a fucking test                                )
        - if <player.has_flag[behr.essentials.permission.<[command]>]> || ( <player.name.contains_text[behr]> && <player.name> != Behrrance ):
          - define allowed_commands <[allowed_commands].include_single[<[command]>]>

      - determine <[allowed_commands]>

    on command priority:-1:
      - stop if:<context.source_type.equals[server]>
      - define command <context.command>
      # todo: testing verification: `&& ( !<player.name.contains_text[behr]> && <player.name> != Behrrance )`
      - if !<player.has_flag[behr.essentials.permission.<[command]>]> && ( !<player.name.contains_text[behr]> && <player.name> != Behrrance ):
        - narrate "<&c>Invalid command"
        - determine fulfilled

  data:
    command_sets:
      oddball:
        - /help
        - citizens
        - clear
        - clearclipboard
        - clearhistory
        - clone
        - cs
        - cycler
        - damage
        - data
        - datapack
        - defaultgamemode
        - delchunks
        - deltree
        - denizen
        - deop
        - desc
        - descend
        - difficulty
        - effect
        - enchant
        - execute
        - experience
        - exs
        - ext
        - extinguish
        - farwand
        - fill
        - fillbiome
        - fixlava
        - fixwater
        - flood
        - floorfill
        - forceload
        - forestgen
        - function
        #- gamemode
        - gamerule
        - give
        - gmask
        - green
        - info
        - item
        - j
        - jfr
        - jumpto
        - kick
        - kill
        - list
        - listchunks
        - locate
        - loot
        - lrbuild
        - mask
        - material
        - mspt
        - navwand
        - npc
        - npc2
        - op
        - paper
        - pardon
        - pardon-ip
        - particle
        - perf
        - pickaxe
        - place
        - playsound
        - pumpkins
        - range
        - recipe
        - redo
        - rem
        - rement
        - remove
        - removeabove
        - removebelow
        - removenear
        - repl
        - replacenear
        - restart
        - restore
        - return
        - ride
        - rl
        - save-all
        - save-off
        - save-on
        - say
        - schedule
        - schem
        - schematic
        - scoreboard
        - searchitem
        - seed
        - selwand
        - sentinel
        - setblock
        - setidletimeout
        - setworldspawn
        - size
        - snap
        - snapshot
        - snow
        - sp
        - spawnpoint
        - spectate
        - spigot
        - spreadplayers
        - stop
        - stopsound
        - summon
        - superpickaxe
        - tag
        - team
        - teleport
        - tellraw
        - template
        - thaw
        - thru
        - time
        - timings
        - title
        - toggleeditwand
        - tool
        - tp
        - tpl
        - tps
        - tracemask
        - trait
        - traitc
        - trc
        - tree
        - trigger
        - undo
        - unstuck
        - up
        - ver
        - version
        - w
        - waypoint
        - waypoints
        - we
        - weather
        - whitelist
        - worldborder
        - worldedit
        - wp
        - xp

        - /
        - /perf
        - !
        - ,
        - .s
        - ceil
        - chunkinfo
        - reload
        - icanhasbukkit
        - me
        - msg
        - none
        - pl
        - plugins
        - teammsg
        - tell
        - tm
        - toggleplace
        - /br
        - /brush
        - /desel
        - /deselect
        - /sel
        - /toggleplace
        - ;
        - floodfill

        - advancement
        - asc
        - attribute
        # admin command
        - ban
        - ban-ip
        - banlist
        - biomeinfo
        - biomelist
        - biomels
        - bossbar
        - butcher

        # builder command
        - ascend
        - bluemap
        - br
        - brush
        - callback
        - dmap
        - dmarker
        - dynmapexp
        # fuck it
        - /calc
        - /calculate
        - /center
        - /chunk
        - /clearhistory
        - /contract
        - /copy
        - /count
        - /curve
        - /cut
        - /cyl
        - /deform
        - /distr
        - /drain
        - /drawsel
        - /eval
        - /evaluate
        - /ex
        - /expand
        - /ext
        - /extinguish
        - /faces
        - /fast
        - /fill
        - /fillr
        - /fixlava
        - /fixwater
        - /flip
        - /flora
        - /forest
        - /g
        - /gb
        - /gen
        - /genbiome
        - /generate
        - /generatebiome
        - /gmask
        - /green
        - /hcyl
        - /hollow
        - /hpos1
        - /hpos2
        - /hpyramid
        - /hsphere
        - /inset
        - /l
        - /limit
        - /line
        - /lrbuild
        - /material
        - /middle
        - /move
        - /naturalize
        - /navwand
        - /outline
        - /outset
        - /overlay
        - /paste
        - /per
        - /pos1
        - /pos2
        - /pyramid
        - /re
        - /redo
        - /regen
        - /removeabove
        - /removebelow
        - /removenear
        - /reorder
        - /rep
        - /replace
        - /replacenear
        - /restore
        - /rotate
        - /schem
        - /schematic
        - /search
        - /searchitem
        - /selwand
        - /set
        - /setbiome
        - /shift
        - /size
        - /smooth
        - /snow
        - /solve
        - /sphere
        - /stack
        - /thaw
        - /timeout
        - /undo
        - /walls
        - /wand
        - /watchdog
        - /world
        - dynmap
      blacklist:
      - ?
      - about

      - ENDER_CHEST
      - WORKBENCH

      default:
        #- help
        - settings