note
	description : "Exemple of the use of the {CHAIN_INDEXABLE_ITERATOR}."
	date        : "July 23, 2014"
	revision    : "1.0.1.1"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			l_list:ARRAYED_LIST[STRING]
			l_iterator:CHAIN_INDEXABLE_ITERATOR[STRING]
		do
			create l_list.make (5)
			l_list.extend ("Item 1")
			l_list.extend ("Item 2")
			l_list.extend ("Item 3")
			l_list.extend ("Item 4")
			l_list.extend ("Item 5")
			create l_iterator.make(l_list)
			print("%NHere is all element of the list%N")
			across l_iterator as la_iterator loop
				print(la_iterator.item + "%N")
			end
			print("%N%NHere is the item 2 to 4%N")
			from
				l_iterator.go_i_th (2)
			until
				l_iterator.index>4
			loop
				print(l_iterator.item + "%N")
				l_iterator.forth
			end
			print("%N%NHere is the item 1: " + l_iterator.at (1))
			print("%N%NHere is the item 3: " + l_iterator.at (3))
			print("%N")
		end

end
