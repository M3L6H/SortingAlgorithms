# Slow. O(n^2)

def selection_sort!(arr, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    i = 0
    while i < arr.size - 1
        _, min_idx = arr[i..-1].each_with_index.min { |a, b| prc.call(a[0], b[0]) }
        arr[i], arr[min_idx + i] = arr[min_idx + i], arr[i]
        i += 1
    end
    arr
end

def selection_sort(arr, &prc)
    selection_sort!(arr.dup, &prc)
end

if $PROGRAM_NAME == __FILE__
    arr = [1,5,43,46,2,24,17,4,654,2,67,457,345,7,2,436,73,4,345,3,1,4,6,567,7,64]
    
    p selection_sort(arr)
    p arr
    
    p selection_sort!(arr) { |b, a| a <=> b }
end

