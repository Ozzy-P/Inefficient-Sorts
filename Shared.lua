--!strict
-- Shared methods here (e.g. HeapSort, MaxHeap)
-- Assumes type of generic has a metamethod that returns a comparable value to functions (e.g. generic OOP)
local heap = {}
export type indexArray<E> = {
	heap : {
		[number] : E
	}, 
	_HEAPSIZE : number
}

export type keyTable<E> = {
	value: E,
	key : number,
}

export type keyArray<E> = {
	heap : {
		keyTable<number>
	},
	_HEAPSIZE : number
}

heap.PARENT = function(i:number)
	return math.floor(i/2);
end

heap.LEFT = function(i:number)
	return 2*i;
end

heap.RIGHT = function(i:number)
	return 2*i + 1;
end

heap.MAX_HEAPIFY = function(A:indexArray<number>, i:number)
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
		local tmp = A.heap[i];
		A.heap[i] = A.heap[largest];
		A.heap[largest] = tmp;
		heap.MAX_HEAPIFY(A, largest);
	end
end

heap.BUILD_MAX_HEAP = function(A:indexArray<number>)
	for i = math.floor(A._HEAPSIZE/2), 1, -1 do
		heap.MAX_HEAPIFY(A,i);
	end
end

heap.MAX_HEAP_MAXIMUM = function(A:indexArray<number>)
	if A._HEAPSIZE < 1 then
		error("Invalid heap size for operation!");
	end
	return A.heap[1];
end

heap.MAX_HEAP_EXTRACT_MAX = function(A:indexArray<number>)
	local MAXIMUM = heap.MAX_HEAP_MAXIMUM(A);
	A.heap[1] = A.heap[A._HEAPSIZE];
	A._HEAPSIZE -= 1;
	heap.MAX_HEAPIFY(A,1);
	return MAXIMUM;
end

-- Must implement a comparable where x returns a value similar to heap array type.
heap.MAX_HEAP_INCREASE_KEY = function(A:keyArray<number>, x:keyTable<number>, k:number)
	if k < x.key then
		error("MAX_HEAP_INCREASE may only increase the respective value of the object.");
	end
	x.key = k;
	local i = nil;
	do
		for n = 1, A._HEAPSIZE do
			if A[n].value == x.value then
				i = n
				break;
			end
		end
	end
	if(i == nil) then
		error("Failed to find instance(s) of object X: ", x.value)
	end
	while i > 1 and A.heap[heap.PARENT(i)].key < A.heap[i].key do
		-- TODO:
		-- Do this, cause it's not explained, or will be explained in the near future.
		i = heap.PARENT(i);
	end
end

heap.HEAPSORT = function(A:indexArray<number>)
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

return heap
