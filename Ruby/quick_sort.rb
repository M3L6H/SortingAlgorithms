# O(n log n) average case
# O(n^2) worst case
# In-place
# Unstable

def partition!(arr, start_idx, end_idx, &prc)
    pivot = end_idx - 1
    partIdx = start_idx
    (start_idx...pivot).each do |i|  
        if prc.call(arr[i], arr[pivot]) == -1
            arr[i], arr[partIdx] = arr[partIdx], arr[i] 
            partIdx += 1
        end
    end
    arr[pivot], arr[partIdx] = arr[partIdx], arr[pivot]
    partIdx
end

def quick_sort_rec!(arr, start_idx, end_idx, &prc)
    return arr if end_idx - start_idx <= 1
    pivot = partition!(arr, start_idx, end_idx, &prc)
    quick_sort_rec!(arr, start_idx, pivot, &prc)
    quick_sort_rec!(arr, pivot + 1, end_idx, &prc)
end

def quick_sort!(arr, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    quick_sort_rec!(arr, 0, arr.size, &prc)
end

def quick_sort(arr, &prc)
    new_arr = []
    arr.each { |ele| new_arr << ele }
    quick_sort!(new_arr, &prc)
end

if $PROGRAM_NAME == __FILE__
    arr = [1,5,43,46,2,24,17,4,654,2,67,457,345,7,2,436,73,4,345,3,1,4,6,567,7,64]
    
    p quick_sort(arr)
    p arr
    
    p quick_sort!(arr) { |b, a| a <=> b }
end
