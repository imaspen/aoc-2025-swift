extension Sequence where Element: Numeric {
	public func sum() -> Element {
		return self.reduce(.zero, +)
	}

	public func product() -> Element {
		return self.reduce(1, *)
	}
}
