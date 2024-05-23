//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

extension ColorSample {

    // MARK: ColorSample - ComponentList

    public var componentList: some RandomAccessCollection<ComponentIntensity> {
        ColorSampleComponentList(colorSample: self)
    }
}

fileprivate struct ColorSampleComponentList<ColorSampleType: ColorSample> {

    // MARK: ColorSampleComponentList - Initialization

    fileprivate init(colorSample: ColorSampleType) {
        self.colorSample = colorSample
    }

    // MARK: ColorSampleComponentList - Representation

    private let colorSample: ColorSampleType
}

extension ColorSampleComponentList: Sequence {

    // MARK: Sequence - Element

    fileprivate typealias Element = ColorSampleType.ComponentIntensity
}

extension ColorSampleComponentList: Collection {

    // MARK: Collection

    fileprivate var count: Int {
        colorSample.space.componentCount
    }

    // MARK: Collection - Index

    fileprivate typealias Index = ColorSampleType.Space.ComponentIndex

    fileprivate var startIndex: Index { 0 }

    fileprivate var endIndex: Index { count }

    fileprivate func index(after anotherIndex: Index) -> Index {
        index(anotherIndex, offsetBy: 1)
    }

    fileprivate func index(_ anotherIndex: Index, offsetBy distance: Int) -> Index {
        anotherIndex + distance
    }

    fileprivate func index(_ anotherIndex: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        let resultingIndex = index(anotherIndex, offsetBy: distance)
        guard distance >= 0 ? resultingIndex <= limit : resultingIndex >= limit else {
            return nil
        }
        return resultingIndex
    }

    // MARK: Collection - Element

    fileprivate subscript(_ index: Index) -> Element {
        let component = colorSample.space.componentForIndex(index)
        return if let componentIntensity = colorSample[component: component] {
            componentIntensity
        } else {
            colorSample.space.defaultIntensityForComponent(component)
        }
    }
}

extension ColorSampleComponentList: BidirectionalCollection {

    // MARK: BidirectionalCollection

    fileprivate func index(before anotherIndex: Index) -> Index {
        index(anotherIndex, offsetBy: -1)
    }
}

extension ColorSampleComponentList: RandomAccessCollection {
    /* This scope is intentionally left blank. */
}
