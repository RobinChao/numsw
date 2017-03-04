public struct Matrix {
    
    var rows: Int
    var columns: Int
    
    var elements: [Double]
    
    public init(rows: Int, columns: Int, elements: [Double]) {
        self.rows = rows
        self.columns = columns
        self.elements = elements
    }
    
    public static func zeros(rows: Int, columns: Int) -> Matrix {
        let count = columns * rows
        let cElements = UnsafeMutablePointer<Double>.allocate(capacity: count)
        defer { cElements.deallocate(capacity: count) }
        for i in 0..<count {
            cElements[i] = Double(0)
        }
        return Matrix(rows: rows, columns: columns, elements: Array(UnsafeBufferPointer(start: cElements, count: count)))
    }
    
    public static func ones(rows: Int, columns: Int) -> Matrix {
        let count = columns * rows
        let cElements = UnsafeMutablePointer<Double>.allocate(capacity: count)
        defer { cElements.deallocate(capacity: count) }
        for i in 0..<count {
            cElements[i] = Double(1)
        }
        return Matrix(rows: rows, columns: columns, elements: Array(UnsafeBufferPointer(start: cElements, count: count)))
    }
    
    public static func eye(size: Int) -> Matrix {
        var matrix = Matrix.zeros(rows: size, columns: size)
        for i in 0..<size {
            matrix.elements[i + i * matrix.columns] = 1
        }
        return matrix
    }
}

extension Matrix {
    public func reshaped(rows: Int, cols: Int) -> Matrix {
        assert(rows * columns == self.rows * self.columns, "Element count must be unchanged.")
        
        return Matrix(rows: rows, columns: columns, elements: self.elements)
    }
}