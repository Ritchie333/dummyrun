#!/usr/bin/env python3

from enum import IntEnum

import html

import skoolkit.graphics
from skoolkit.graphics import Frame, Udg
from skoolkit.skoolhtml import HtmlWriter

class HerbertHtmlWriter(HtmlWriter):

    class LogicState(IntEnum):
        PATTERN = 0xF1
        ACTION = 0xFD
        END = 0xFF

    class GraphicsState(IntEnum):
        SPACE = 0xF5
        MOVE_DOWN_LEFT = 0xF3
        REPEAT_UP_RIGHT = 0xF9
        REPEAT_COL_PAIRS = 0xF7
        REPEAT_ROW_PAIRS = 0xF8
        NEW_ADDR = 0xFB
        REPEAT_COLS = 0xFD
        ATTR = 0xFE
        END = 0xFF

    class Pattern(IntEnum):
        ATHEAD = 0
        ATFOOT = 1
        HAS = 2
        TESTLIFT = 3
        ISLIFT = 4
        WON = 5
        IS = 6

    poneargs = [ Pattern.HAS, Pattern.TESTLIFT, Pattern.ISLIFT ]
    ptwoargs = [ Pattern.ATHEAD, Pattern.ATFOOT, Pattern.IS ]

    pobjargs = [ Pattern.HAS ]
    pflagargs = [ Pattern.IS ]
    pchrargs = [  ]

    class Action(IntEnum):
        SWAP_FOR = 0
        SWAP = 1
        MOVE = 2
        MOVE_LIFT = 3
        PRESS_LIFT = 4
        CALL = 5
        SET = 6

    aoneargs = [ Action.SWAP_FOR, Action.SET, Action.MOVE_LIFT, Action.PRESS_LIFT, Action.CALL ]
    atwoargs = [ Action.SET ]
    athreeargs = [ Action.MOVE ]
    aobjargs = [ Action.SWAP_FOR ]
    aflagargs = [ Action.SET ]

    class Flag(IntEnum):
        TENPENCE_REAL = 1
        POPGUN_LOADED = 2
        CATAPULT_LOADED = 4
        TORCH_WORKING = 5,
        SHOT_DUCKS = 6,
        CANNON_LOADED = 7,
        ROPE_PULLED = 10

    def debug( self, addr ):
        print( hex( addr ), hex( self.snapshot[ addr ] ) )

    def print_pattern( self, pattern, n, op ):
        if( pattern in self.pobjargs and n == 1 ):
            return self.print_object( op )
        if( pattern in self.pflagargs and n == 1 ):
            return HerbertHtmlWriter.Flag( op ).name
        else:
            return str( op )
        
    def print_action( self, action, n, op ) :
        if( action == HerbertHtmlWriter.Action.CALL ):
            return self.print_call( op )
        if( action in self.aobjargs and n == 1 ):
            return self.print_object( op )
        if( action in self.aflagargs and n == 1 ):
            return HerbertHtmlWriter.Flag( op ).name
        else:
            return str( op )

    def print_call( self, op ):
        calls = { 0: 'HANDLE_BOXES', 3: 'REFRESH_INVENTORY', 8: 'FIRE_CANNON', 9: 'THROW_SWITCH', 11: 'PULL_ROPE', 12: 'REFRESH_SWITCH'}

        return calls[ op ]

    def print_object( self, obj_id ):
        base = 0xA07C
        
        if obj_id == 0:
            addr = base
        else:
            addr = base
            nth = 0
            while nth < obj_id :
                if self.snapshot[ addr ] == 0xff:
                    nth += 1
                addr += 1

        # Hack for the few items with variable descriptions

        custom = { 0xa0f2: 'TEN PENCE', 0xa136: 'POP GUN', 0xa17f: 'TORCH', 0xa1c9: 'CATAPULT' }

        text = ''
        
        if addr in custom:
            text = 'THE ' + custom[ addr ]
        else:
            next = self.snapshot[ addr ]

            while next != HerbertHtmlWriter.LogicState.END:

                if( next > 0x60 ):
                    text += ' '
                    addr += 1
                else:
                    text += chr( next )
                addr += 1
                next = self.snapshot[ addr ]
        return text

    def print_logic( self, cwd, addr ):

        text = ''

        first_pattern = True

        current_state = HerbertHtmlWriter.LogicState.PATTERN

        next = self.snapshot[ addr ]
        while next != HerbertHtmlWriter.LogicState.END:

            if( next == HerbertHtmlWriter.LogicState.PATTERN ):
                if not( first_pattern ):
                    text = text + 'END IF<br/>'
                first_pattern = True
                current_state = HerbertHtmlWriter.LogicState.PATTERN
                addr = addr + 1

            if( next == HerbertHtmlWriter.LogicState.ACTION ) :
                text = text + '</br>'
                if not( first_pattern ):
                    text = text + ' THEN</br>'
                current_state = HerbertHtmlWriter.LogicState.ACTION
                addr = addr + 1

            if( next != HerbertHtmlWriter.LogicState.PATTERN and next != HerbertHtmlWriter.LogicState.ACTION and next != HerbertHtmlWriter.LogicState.END ):
                if( current_state == HerbertHtmlWriter.LogicState.PATTERN ):
                    if( first_pattern ):
                        text = text + '<br/>IF '
                        first_pattern = False
                    else:
                        text = text + '</br> AND '

                    pattern = HerbertHtmlWriter.Pattern( self.snapshot[ addr ] )
                    addr = addr + 1

                    text = text + pattern.name + '( '

                    if( pattern in self.poneargs or pattern in self.ptwoargs ):

                        op = self.snapshot[ addr ]
                        addr = addr + 1

                        text = text + self.print_pattern( pattern, 1, op )

                        if( pattern in self.ptwoargs ):

                            op2 = self.snapshot[ addr ]
                            addr = addr + 1

                            text = text + ', ' + self.print_pattern( pattern, 2, op2 ) 

                    text = text + ' ) '

                if( current_state == HerbertHtmlWriter.LogicState.ACTION ):
                    action = HerbertHtmlWriter.Action( self.snapshot[ addr ] )
                    addr = addr + 1

                    if not first_pattern:
                        text += '&nbsp;&nbsp;'
                    text += action.name

                    if( action in self.aoneargs or action in self.atwoargs or action in self.athreeargs ):
                        text = text + '( '

                        op = self.snapshot[ addr ]
                        addr = addr + 1

                        text = text + self.print_action( action, 1, op )

                        if( action in self.atwoargs or action in self.athreeargs ):
                            op2 = self.snapshot[ addr ]
                            addr = addr + 1

                            text = text + ', ' + self.print_action( action, 2, op2 )

                            if( action in self.athreeargs ) :
                                op3 = self.snapshot[ addr ]
                                addr = addr + 1

                                text = text + ', ' + self.print_action( action, 3, op3 )

                        text = text + ' )'
                    text = text + '<br/>'
                    
            next = self.snapshot[ addr ]

        return self.expand( text, cwd )

    def print_room_stats( self, cwd, addr ):

        text = ''
        for id, x, y in self.enum_room_data( addr, True ):
            ptr = self.get_block_ptr_from_id( id )
            text += '<br/>{' + f'#R${ptr:x}|{id}' + '}' + ' ' + str(x) + ',' + str(y)
        return self.expand( text, cwd )


    def print_room_data( self, cwd, addr, fName ):

        bg = self.make_background()

        for id, x, y in self.enum_room_data( addr, False ):
            self.make_block_data( bg, self.get_block_ptr_from_id( id ), 0, x, y, 0 )
        
        bgf = self.make_background()
        for id, x, y in self.enum_room_data( addr, True ):
            self.make_block_data( bgf, self.get_block_ptr_from_id( id ), 0, x, y, 0 )

        frames = [ Frame( bg, scale=2, delay=100 ), Frame( bgf, scale=2, delay=100 ) ]
        return self.handle_image( frames, fName, cwd )

    def get_block_ptr_from_id( self, id ):
        offset = 0xBD86 + 2 * id
        ptr = self.snapshot[ offset ] + 0x100 * self.snapshot[ offset + 1 ]
        return ptr

    def enum_room_data( self, addr, flags ):
        x = self.snapshot[ addr ]
        y = self.snapshot[ addr + 1 ]
        id = self.snapshot[ addr + 2 ]
        addr += 3

        while( x != 0xFF ):

            if( x == 0xF5):
                addr += 1

            if id == 0xDE:
                if not flags:
                    # Skip over flag-dependent graphics on this run
                    addr += 2
            else:

                yield id, x, y

            x = self.snapshot[ addr ]
            y = self.snapshot[ addr + 1 ]
            id = self.snapshot[ addr + 2 ]
            addr += 3

    def print_block_data( self, cwd, addr, fName ):
        
        bg = self.make_background()

        base = 0
        attr = 0
        x = 0
        y = 5

        self.make_block_data( bg, addr, base, x, y, attr )

        frame = Frame( bg, 2 )
        return self.handle_image( frame, fName, cwd )
    
    def two_comp_add( x, dx ):
        if( dx < 0x80 ):
            x += dx
        else:
            x -= (0x100 - dx )
        return x

    def make_block_data( self, bg, addr, base, x, y, attr ):

        next = self.snapshot[ addr ]
        addr += 1
        while ( next != HerbertHtmlWriter.GraphicsState.END ):

            if ( next >= 0xC1 and next <= 0xC9 ):
                attr = ( next - 0xC2 )

            if ( next >= 0xCA and next <= 0xD0 ):
                attr = ( next - 0x89 )

            if ( next >= 0x9E and next <= 0xC0 ):
                rows = ( next - 0xA0 )
                id = self.snapshot[ addr ]
                for i in range( 0, rows ):
                    self.print_udg( bg, base, id, x , y, attr )
                    y += 1

            if ( next >= 0x5D and next <= 0x9D ):
                if( next >= 0x7D ):
                    dx = next - 0x7D
                else:
                    dx = 0 - ( 0x7D - next )
                dy = self.snapshot[ addr ]
                addr += 1
                x = HerbertHtmlWriter.two_comp_add( x, dx )
                y = HerbertHtmlWriter.two_comp_add( y, dy )

            if( next == HerbertHtmlWriter.GraphicsState.NEW_ADDR ):
                base = self.snapshot[ addr ] + 0x100 * self.snapshot[ addr + 1 ]
                addr += 2

            if ( next == HerbertHtmlWriter.GraphicsState.SPACE ):
                x += 1
                
            if( next == HerbertHtmlWriter.GraphicsState.REPEAT_COLS ):
                cols = self.snapshot[ addr ]
                addr += 1
                id = self.snapshot[ addr ]
                addr += 1
                for i in range( 0, cols ):
                    self.print_udg( bg, base, id, x, y, attr )
                    x += 1

            if( next == HerbertHtmlWriter.GraphicsState.REPEAT_COL_PAIRS ):
                cols = self.snapshot[ addr ]
                addr += 1
                id = self.snapshot[ addr ]
                addr += 1
                id2 = self.snapshot[ addr ]
                addr += 1
                for i in range( 0, cols ):
                    self.print_udg( bg, base, id, x, y, attr )
                    x += 1
                    self.print_udg( bg, base, id2, x, y, attr )
                    x += 1

            if( next == HerbertHtmlWriter.GraphicsState.MOVE_DOWN_LEFT ):
                x -= 1
                y += 1

            if( next == HerbertHtmlWriter.GraphicsState.REPEAT_UP_RIGHT ):
                repeat = self.snapshot[ addr ]
                addr += 1
                id = self.snapshot[ addr ]
                addr += 1
                for i in range( 0, repeat ):
                    self.print_udg( bg, base, id, x, y, attr )
                    y += 1
                    x -= 1


            if( next == HerbertHtmlWriter.GraphicsState.ATTR ):
                attr = self.snapshot[ addr ]
                addr += 1

            if( next < 0x5C ):
                id = next
                self.print_udg( bg, base, id, x, y, attr )
                x += 1

            next = self.snapshot[ addr ]
            addr += 1

    def make_background( self ):
        udgs = []
        for y in range( 0, 24 ):
            nextUdgs = []
            for x in range( 0, 32 ):
                nextUdgs.append( Udg( 0, [ 0, 0, 0, 0, 0, 0, 0, 0]))
            udgs.append( nextUdgs )
        return udgs

    def print_udg( self, bg, addr, id, x, y, attr ):

        ptr = addr + ( id * 8 )
        udgs = [ [ Udg( attr, self.snapshot[ ptr : ptr + 8 ] ) ] ]
        skoolkit.graphics.overlay_udgs( bg, udgs, x * 8, y * 8, 0, lambda bg, fg : fg, lambda bg, fg, mk : fg )

    def print_platforms( self, cwd, addr, rAddr, fName ):

        bg = self.make_background()
        
        for id, x, y in self.enum_room_data( rAddr, True ):
            self.make_block_data( bg, self.get_block_ptr_from_id( id ), 0, x, y, 0 )

        ch = self.snapshot[ addr ]
        while ch != 0xFF:
            self.print_platform( bg, ch, self.snapshot[ addr + 1 ], self.snapshot[ addr + 2 ])
            addr += 3
            ch = self.snapshot[ addr ]
        frame = Frame( bg, 2 )
        return self.handle_image( frame, fName, cwd )

    def print_platform( self, bg, y, x1, x2 ):
            udg = Udg( 0, [ 0, 0, 0, 0, 0, 0, 0, 0 ])
            udgs = []
            for i in range( x1, x2 ):
                udgs.append( udg )
            skoolkit.graphics.overlay_udgs( bg, [ udgs ], x1 * 8, y, 0, lambda bg, fg : bg + 0x80 )