# O(n log n) worst case runtime
# O(n) space complexity
# Divide and conquer + recursive
# Stable
# Not in-place

def merge(a, b, arr, &prc)
    i, j, k = 0, 0, 0
    while i < a.size && j < b.size
        if prc.call(a[i], b[j]) == -1
            arr[k] = a[i]
            i += 1
        else
            arr[k] = b[j]
            j += 1
        end
        k += 1 
    end
    while i < a.size
        arr[k] = a[i]
        i += 1
        k += 1
    end
    while j < b.size
        arr[k] = b[j]
        j += 1
        k += 1
    end
    arr
end

def merge_sort!(arr, &prc)
    return arr if arr.size <= 1
    prc ||= Proc.new { |a, b| a <=> b }
    merge(merge_sort!(arr[0...arr.size / 2], &prc), merge_sort!(arr[arr.size / 2..-1], &prc), arr, &prc)
end

def merge_sort(arr, &prc)
    new_arr = []
    arr.each { |ele| new_arr << ele }
    merge_sort!(new_arr, &prc)
end

if $PROGRAM_NAME == __FILE__
    arr = [1,5,43,46,2,24,17,4,654,2,67,457,345,7,2,436,73,4,345,3,1,4,6,567,7,64]
    
    p merge_sort(arr)
    p arr
    
    p merge_sort!(arr) { |b, a| a <=> b }
end


