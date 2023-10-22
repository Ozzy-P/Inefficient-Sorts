--!strict
-- Shared methods here (e.g. HeapSort, MaxHeap)
-- Assumes type of generic has a metamethod that returns a comparable value to functions (e.g. generic OOP)
local sorts = {
	Heap = {},
	QuickSort = {},
}

export type IndexArray<E> = {
	heap : {
		[number] : E
	}, 
	_HEAPSIZE : number
}

export type KeyTable<E> = {
	value: E,
	key : number,
}

export type KeyArray<E> = {
	heap : {
		KeyTable<number>
	},
	_HEAPSIZE : number
}

export type Array<E> = {
	[number]: number
}

local heap = sorts.Heap
local quicksort = sorts.QuickSort

heap.PARENT = function(i:number)
	return math.floor(i/2);
end

heap.LEFT = function(i:number)
	return 2*i;
end

heap.RIGHT = function(i:number)
	return 2*i + 1;
end

heap.MAX_HEAPIFY = function(A:IndexArray<number>, i:number)
	local l = heap.LEFT(i);
	local r = heap.RIGHT(i);
	local largest = i;
	if l <= A._HEAPSIZE and A.heap[l] > A.heap[i] then
		largest = l;
	end
	if r <= A._HEAPSIZE and A.heap[r] > A.heap[largest] then
		largest = r;
	end
	if largest ~= i then
		-- TODO:
		-- Minimize overhead for 3 accesses.
		local tmp = A.heap[i];
		A.heap[i] = A.heap[largest];
		A.heap[largest] = tmp;
		heap.MAX_HEAPIFY(A, largest);
	end
end

heap.BUILD_MAX_HEAP = function(A:IndexArray<number>)
	for i = math.floor(A._HEAPSIZE/2), 1, -1 do
		heap.MAX_HEAPIFY(A,i);
	end
end

heap.MAX_HEAP_MAXIMUM = function(A:IndexArray<number>)
	if A._HEAPSIZE < 1 then
		error("Invalid heap size for operation!");
	end
	return A.heap[1];
end

heap.MAX_HEAP_EXTRACT_MAX = function(A:IndexArray<number>)
	local MAXIMUM = heap.MAX_HEAP_MAXIMUM(A);
	A.heap[1] = A.heap[A._HEAPSIZE];
	A._HEAPSIZE -= 1;
	heap.MAX_HEAPIFY(A,1);
	return MAXIMUM;
end

-- Must implement a comparable where x returns a value similar to heap array type.
heap.MAX_HEAP_INCREASE_KEY = function(A:KeyArray<number>, x:KeyTable<number>, k:number)
	if k < x.key then
		error("MAX_HEAP_INCREASE may only increase the respective value of object [X]!");
	end
	x.key = k;
	local i = nil;
	for n = 1, A._HEAPSIZE do
		if A.heap[n].value == x.value then
			i = n
			break;
		end
	end
	if(i == nil) then
		error("Failed to find instance(s) of object X: ", x.value)
	end
	while i > 1 and A.heap[heap.PARENT(i)].key < A.heap[i].key do
		-- TODO:
		-- Do this, cause it's not explained, or will be explained in the near future.
		-- (Update references in the heap after swapping the values)
		i = heap.PARENT(i);
	end
end

heap.HEAPSORT = function(A:IndexArray<number>)
	heap.BUILD_MAX_HEAP(A);
	local sorted = {};
	for i = A._HEAPSIZE, 2, -1 do
		local tmp = A.heap[i];
		A.heap[i] = A.heap[1];
		A.heap[1] = tmp;
		A._HEAPSIZE -= 1;
		heap.MAX_HEAPIFY(A,1);
	end
	return sorted;
end

quicksort.PARTITION = function(A:Array<number>, p:number, r:number)
	local x = A[r]
	local i = p-1;
	for j = p, r-1 do
		if A[j] <= x then
			i += 1;
			local tmp = A[i];
			A[i] = A[j];
			A[j] = tmp;
		end
	end
	-- TODO:
	-- Minimize overhead for 3 accesses.
	local tmp = A[i+1];
	A[i+1] = A[r];
	A[r] = tmp;
	return i+1;
end

-- This one is REALLY slow, please, don't.
quicksort.QUICKSORT = function(A:Array<number>, p:number, r:number)
	if p < r then
		local q = sorts.QuickSort.PARTITION(A, p, r)
		quicksort.QUICKSORT(A, p, q-1);
		quicksort.QUICKSORT(A, q+1, r)
	end
	
end

return {
	HeapSort = sorts.Heap.HEAPSORT, 
	QuickSort = sorts.QuickSort.QUICKSORT,
};
