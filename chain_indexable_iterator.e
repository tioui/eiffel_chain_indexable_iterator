note
	description: "[
			Objects that are able to iterate over a {CHAIN} structures (forward and backward) 
			and the content can be addressed with integers key.
			Can be use to access a {CHAIN} in read only.
		]"
	author: "Louis Marchand"
	date: "July 23, 2014"
	revision: "1.0.1.1"

class
	CHAIN_INDEXABLE_ITERATOR [G]

inherit
	READABLE_INDEXABLE [G]
		rename
			item as i_th alias "[]"
		end

	BILINEAR [G]

	FINITE [G]

create
	make

feature {NONE} -- Initialization

	make(a_target:CHAIN[G])
			-- Initialization of `Current' using `a_target' as the data container.
		require
			A_Target_Not_Void: a_target /= Void
		do
			target := a_target
		ensure
			Target_Not_Void: target /= Void
		end

feature {NONE} -- Implementation

	target: CHAIN [G]
			-- The {CHAIN} object containing the data

feature -- Access

	item: G
			-- <Precursor>
		do
			Result := target.item
		end

	index_set: INTEGER_INTERVAL
			-- <Precursor>
		do
			create Result.make(1, count)
		end

	i_th alias "[]" (i: INTEGER): G
			-- <Precursor>
		do
			Result := target.at(i)
		end

	at alias "@" (i: INTEGER): G
			-- Entry at position `i'
		require
			I_Valid: valid_index (i)
		do
			Result := i_th(i)
		end

	index:INTEGER
			-- <Precursor>
		do
			Result := target.index
		end

feature -- Measurement

	count : INTEGER
			-- <Precursor>
		do
			Result := target.count
		end

feature -- Status report

	readable: BOOLEAN
			-- Is there a current item that may be read?
		do
			Result := target.readable
		end

	valid_index (i: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := (i >= 1) and (i <= count)
		end

	after: BOOLEAN
			-- <Precursor>
		do
			Result := target.after
		end

	before: BOOLEAN
			-- <Precursor>
		do
			Result := target.before
		end

	full: BOOLEAN
			-- <Precursor>
		do
			Result := target.full
		end

	valid_cursor_index (i: INTEGER): BOOLEAN
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := target.valid_cursor_index (i)
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

feature -- Cursor movement

	start
			-- <Precursor>
		do
			target.start
		end

	finish
			-- <Precursor>
		do
			target.finish
		end

	forth
			-- <Precursor>
		do
			target.forth
		end

	back
			-- <Precursor>
		do
			target.back
		end

	move (i: INTEGER)
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the absolute value of `i'
			-- is too big.
		do
			target.move (i)
		ensure
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
		end

	go_i_th (i: INTEGER)
			-- Move cursor to `i'-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			target.go_i_th (i)
		ensure
			position_expected: target.index = i
		end

invariant

	Target_Not_Void: target /= Void

note
	copyright: "Copyright (c) 2014, Louis Marchand"
	license:   "MIT License (see http://opensource.org/licenses/MIT)"
end
