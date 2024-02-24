bedit_pos1_command:
  type: command
  debug: false
  enabled: true
  name: /pos1
  usage: //pos1 (<&ns>/direction) (<&ns>)
  description: Manual selectors for positions
  tab completions:
    1: north|northeast|east|southeast|south|southwest|west|northwest|up|down|left|right|forward|backward|cursor_on
  data:
    direction:
      north: 0,0,-1
      northeast: 1,0,-1
      east: 1,0,0
      southeast: 1,0,1
      south: 0,0,1
      southwest: -1,0,1
      west: -1,0,0
      northwest: -1,0,-1
      up: 0,1,0
      down: 0,-1,0
      left: <location[0,0,0].with_pose[<player>].left>
      right: <location[0,0,0].with_pose[<player>].right>
      forward: <location[0,0,0].with_pose[<player>].forward_flat>
      back: <location[0,0,0].with_pose[<player>].backward_flat>
  script:
    # % ██ [ Define side and color               ] ██
    - define click_type left
    - choose <context.args.size>:
      # //pos
      - case 0:
        - define location <player.location.with_pose[0,0].round_down>

      - case 1:
        - choose <context.args.first>:
          # //pos cursor_on
          - case cursor_on:
            - define location <player.cursor_on>

          # //pos direction
          - case north northeast east southeast south southwest west northwest up down left right forward back:
            - define direction <script.parsed_key[data.direction.<context.args.first>].as[location]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>

          # //pos1 player_name
          - default:
            - if !<server.match_player[<context.args.first>].if_null[null].is_truthy>:
              - if !<server.match_offline_player[<context.args.first>].if_null[null].is_truthy>:
                - narrate "<&c>Invalid user"
              - else:
                - narrate "<&c>Player is offline"

          - default:
            - inject command_syntax_error

      # //pos # direction
      # //pos direction #
      - case 2:
        - if <context.args.first.is_integer>:
          - define length <context.args.first>
          - if <context.args.last> in <script.parsed_key[data.direction]>:
            - define direction <script.parsed_key[data.direction.<context.args.last>].as[location]>
            - define direction <[direction].mul[<[length]>]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>
          - else:
            - inject command_syntax_error

        - else if <context.args.first> in <script.parsed_key[data.direction]>:
          - define direction <script.parsed_key[data.direction.<context.args.first>].as[location]>
          - if <context.args.last.is_integer>:
            - define length <context.args.last>
            - define direction <[direction].mul[<[length]>]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>
          - else:
            - inject command_syntax_error

        - else:
          - inject command_syntax_error

      - default:
        - inject command_syntax_error


    - define color <[location].map_color>
    - playsound <player> block_amethyst_cluster_place pitch:<util.random.int[7].to[10].div[10]> volume:2
    - remove <player.flag[behr.essentials.bedit.<[click_type]>.selection_entity].if_null[null]> if:<player.flag[behr.essentials.bedit.<[click_type]>.selection_entity].is_truthy>

    # % ██ [ Display selection entity              ] ██
    - spawn bblock[material=glass;glow_color=<[color]>] <[location]> save:block_display
    - define block_display <entry[block_display].spawned_entity>
    - flag player behr.essentials.bedit.<[click_type]>.selection_entity:<[block_display]>
    - flag player behr.essentials.bedit.<[click_type]>.quick_release expire:10s

    - if <[location].material.is_occluding>:
      - playeffect at:<[location].center.above[0.1]> effect:end_rod offset:0.50 quantity:10
    - else:
      - playeffect at:<[location].center.above[0.1]> effect:end_rod offset:0.25 quantity:10

    # % ██ [ Manage flag data and display message  ] ██
      - flag <[location]> behr.essentials.bedit expire:1d
      - flag player behr.essentials.bedit.<[click_type]>.selection:<[location]>
      - define left_selection <player.flag[behr.essentials.bedit.left.selection].if_null[null]>
      - define right_selection <player.flag[behr.essentials.bedit.right.selection].if_null[null]>
      - if <[left_selection].is_truthy> && <[right_selection].is_truthy>:
        - flag player behr.essentials.bedit.selection.cuboid:<[left_selection].to_cuboid[<[right_selection]>]>
        - define cuboid <player.flag[behr.essentials.bedit.selection.cuboid]>
        - actionbar "<&[green]><[click_type]> selecton<&co> <[location].proc[bedit_location_format]> <[cuboid].size.proc[bedit_location_format]>"
      - else:
        - actionbar "<&[green]><[click_type]> selecton<&co> <[location].proc[bedit_location_format]>"

bedit_pos2_command:
  type: command
  debug: false
  enabled: true
  name: /pos2
  usage: //pos2 <&ns>/direction
  description: Manual selectors for positions
  tab completions:
    1: north|northeast|east|southeast|south|southwest|west|northwest|up|down|left|right|forward|backward|cursor_on
  data:
    direction:
      north: 0,0,-1
      northeast: 1,0,-1
      east: 1,0,0
      southeast: 1,0,1
      south: 0,0,1
      southwest: -1,0,1
      west: -1,0,0
      northwest: -1,0,-1
      up: 0,1,0
      down: 0,-1,0
      left: <location[0,0,0].with_pose[<player>].left>
      right: <location[0,0,0].with_pose[<player>].right>
      forward: <location[0,0,0].with_pose[<player>].forward_flat>
      back: <location[0,0,0].with_pose[<player>].backward_flat>
  script:
    # % ██ [ Define side and color                ] ██
    - define click_type right
    - choose <context.args.size>:
      # //pos
      - case 0:
        - define location <player.location.with_pose[0,0].round_down>

      - case 1:
        - choose <context.args.first>:
          # //ppos cursor_on
          - case cursor_on:
            - define location <player.cursor_on>

          # //pos direction
          - case north northeast east southeast south southwest west northwest up down left right forward back:
            - define direction <script.parsed_key[data.direction.<context.args.first>].as[location]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>

          # //pos1 player_name
          - default:
            - if !<server.match_player[<context.args.first>].if_null[null].is_truthy>:
              - if !<server.match_offline_player[<context.args.first>].if_null[null].is_truthy>:
                - narrate "<&c>Invalid user"
              - else:
                - narrate "<&c>Player is offline"

          - default:
            - inject command_syntax_error

      # //pos # direction
      # //pos direction #
      - case 2:
        - if <context.args.first.is_integer>:
          - define length <context.args.first>
          - if <context.args.last> in <script.parsed_key[data.direction]>:
            - define direction <script.parsed_key[data.direction.<context.args.last>].as[location]>
            - define direction <[direction].mul[<[length]>]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>
          - else:
            - inject command_syntax_error

        - else if <context.args.first> in <script.parsed_key[data.direction]>:
          - define direction <script.parsed_key[data.direction.<context.args.first>].as[location]>
          - if <context.args.last.is_integer>:
            - define length <context.args.last>
            - define direction <[direction].mul[<[length]>]>
            - define location <player.flag[behr.essentials.bedit.<[click_type]>.selection].add[<[direction]>].if_null[<player.location.add[<[direction]>].round_down.with_pose[0,0]>]>
          - else:
            - inject command_syntax_error

        - else:
          - inject command_syntax_error

      - default:
        - inject command_syntax_error


    - define color <[location].map_color>
    - playsound <player> block_amethyst_cluster_place pitch:<util.random.int[7].to[10].div[10]> volume:2
    - remove <player.flag[behr.essentials.bedit.<[click_type]>.selection_entity].if_null[null]> if:<player.flag[behr.essentials.bedit.<[click_type]>.selection_entity].is_truthy>

    # % ██ [ Display selection entity              ] ██
    - spawn bblock[material=glass;glow_color=<[color]>] <[location]> save:block_display
    - define block_display <entry[block_display].spawned_entity>
    - flag player behr.essentials.bedit.<[click_type]>.selection_entity:<[block_display]>
    - flag player behr.essentials.bedit.<[click_type]>.quick_release expire:10s

    - if <[location].material.is_occluding>:
      - playeffect at:<[location].center.above[0.1]> effect:end_rod offset:0.50 quantity:10
    - else:
      - playeffect at:<[location].center.above[0.1]> effect:end_rod offset:0.25 quantity:10

    # % ██ [ Manage flag data and display message  ] ██
      - flag <[location]> behr.essentials.bedit expire:1d
      - flag player behr.essentials.bedit.<[click_type]>.selection:<[location]>
      - define left_selection <player.flag[behr.essentials.bedit.left.selection].if_null[null]>
      - define right_selection <player.flag[behr.essentials.bedit.right.selection].if_null[null]>
      - if <[left_selection].is_truthy> && <[right_selection].is_truthy>:
        - flag player behr.essentials.bedit.selection.cuboid:<[left_selection].to_cuboid[<[right_selection]>]>
        - define cuboid <player.flag[behr.essentials.bedit.selection.cuboid]>
        - actionbar "<&[green]><[click_type]> selecton<&co> <[location].proc[bedit_location_format]> <[cuboid].size.proc[bedit_location_format]>"
      - else:
        - actionbar "<&[green]><[click_type]> selecton<&co> <[location].proc[bedit_location_format]>"
