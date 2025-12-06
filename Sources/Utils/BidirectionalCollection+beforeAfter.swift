extension BidirectionalCollection {
	public func before(index: Index) -> Element? {
		guard
			let previousIndex = self.index(
				index,
				offsetBy: -1,
				limitedBy: self.startIndex
			)
		else {
			return nil
		}
		return self[previousIndex]
	}

	public func after(index: Index) -> Element? {
		guard
			let nextIndex = self.index(
				index,
				offsetBy: 1,
				limitedBy: self.index(before: self.endIndex)
			)
		else {
			return nil
		}
		return self[nextIndex]
	}
}
