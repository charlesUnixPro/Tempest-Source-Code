;;;
;;; Build the message tables
;;;
;
; The message attribute table
;
;
; Y-coordinates, colours, and sizes of messages.  X-coordinates vary with
; string length and thus with language; they are therefore stored with the
; (language-specific) string contents.
; Each message has two bytes here.  The first contains the message's
; colour in its high nibble, with its size (b value) in its low nibble.
; The second byte is the Y coordinate (signed).
;
;msg_attr_table:
;	.byte	$51
;	.byte	$56 ; 86 (GAME OVER)
;	.byte	$00
;	.byte	$1a ; 26 (PLAYER )

dnl Macro to generate the msg_attr_table.
dnl Argument is lines of value pairs.
dnl For each line, emit ".byte  arg1, arg2"
dnl

define(`msg_attr_table_',
`msg_attr_table:
patsubst(`$1', `\(\$\w+\) \(\$\w+\)', `.byte	\1, \2')')

;
; The message text tables.
;
; There are four language tables: msgs_en, msgs_fr, msgs_de and msgs_es.
; Each table is an array of pointers to structures containing the message
; X cooordinate and an array of character indices for the text of the message.
; Each element in the pointer array has a symbolic offset allowing the code
; to specify offsets as symbols rather then numbers. The ordering of 
; messages is consistent across the four language tables, so the
; value of offsets is the same for each language (e.g. _msg_en_play == 
; _msg_de_play).
;
;
;msgs_en:
;_msg_en_game_over = * - msgs_en
;	.word   msg_en_game_over ; "FIN DE PARTIE"
;_msg_en_player = * - msgs_en
;        .word   msg_en_player ; "JOUEUR "
;
;msgs_fr:
;_msg_fr_game_over = * - msgs_fr
;	.word   msg_fr_game_over ; "FIN DE PARTIE"
;_msg_fr_player = * - msgs_fr
;        .word   msg_fr_player ; "JOUEUR "
;

dnl Macro to generate an entry in a message table
dnl Arguments are the message text label and the language code.
dnl Generate the line assigning the offset definition and the .word line 

define(`word_offset_', 
`patsubst(`$1',`^', `_')	=	*-msgs_$2
	.word	$1')

dnl Macro to generate a language table. Arguments are the language code
dnl and the list of messages

define(`msg_table_',
`msgs_$1:
patsubst(`$2', `\w+', `word_offset_(msg_$1_\&, $1)')')

dnl Macro to generate the four language tables
dnl Argument is the list of messages

define(`msg_text_tables_',
`msg_table_(en, `$1')
msg_table_(fr, `$1')
msg_table_(de, `$1')
msg_table_(es, `$1')')

dnl Macro to generate the message attribute and text tables

define(`msg_tables_',
`msg_text_tables_(patsubst(`$1', `\(\$\w+ \$\w+\) \(\w+\)', ` \2 '))
msg_attr_table_(patsubst(`$1', `\(\$\w+ \$\w+\) \(\w+\)', ` \1 '))')

; Generate the message attribute and text tables
; Each line contains:
;   A byte specifying The message's colour in the high nibble and
;     its size (b value) in its low nibble.
;   A byte specifying the Y coordinate (signed).
;   The stem of the message label.
; The byte pairs are assembled into the msg_attr_table, and the
; stems are assembled in the language table.
;
;	$51 $56 game_over
;	$00 $1a player
;
; becomes
;
; msg_attr_table:
;       .byte	$51, $56
;	.byte	$00, $1a
; msg_en:
;_msg_en_game_over = * - msg_en
;	.word	msg_en_game_over
;_msg_en_player = * - msg_en
;	.word	msg_en_player
; msg_fr:
;_msg_fr_game_over = * - msg_fr
;	.word	msg_fr_game_over
;_msg_fr_player = * - msg_fr
;	.word	msg_fr_player

msg_tables_(
`	$51 $56 game_over
        $00 $1a player
        $01 $20 player2
        $31 $56 press_start
        $01 $38 play
        $31 $b0 enter_your_initials
        $41 $00 spin_knob_to_change
        $11 $f6 press_fire_to_select
        $30 $38 high_scores
        $31 $ce ranking_from_1_to_
        $51 $0a rate_yourself
        $31 $e2 novice
        $31 $e2 expert
        $51 $ba bonus
        $51 $98 time
        $51 $d8 level
        $51 $c9 hole
        $31 $56 insert_coins
        $51 $80 free_play
        $51 $80 1_coin_2_plays
        $51 $80 1_coin_1_play
        $51 $80 2_coins_1_play
        $71 $92 copyright
        $51 $80 credits
        $31 $b0 bonus2
        $51 $89 2_credit_minimum
        $41 $89 bonus_every
        $00 $00 avoid_spikes
        $71 $5a level2
        $71 $a0 superzapper_recharge')


