package sneaker.format;

using sneaker.format.StringExtension;

import haxe.CallStack.StackItem;
import sneaker.format.CallStackItemExtension.format;

/**
 * Customizable variables and functions used in `CallStackItemExtension.format()`.
 */
@:nullSafety(Strict)
class CallStackItemFormat {
	/**
	 * Set this `true` for hiding file path in `formatFilePos()`.
	 * Defaults to `false`.
	 */
	public static var hideFilePath = false;

	/**
	 * Set this `true` for hiding module path in `formatClass()`.
	 * Defaults to `true`.
	 */
	public static var hideModulePath = true;

	/**
	 * Separator used in `formatFilePos()`.
	 * Can be replaced with any other character or string.
	 */
	public static var separator = " ";

	/**
	 * Formatting function used in `formatFilePos()`.
	 * Can be replaced with any custom function.
	 */
	public static var formatLineColumn = (line:Int, column:Null<Int>) -> {
		return 'line ${line}${column != null ? ", col " + column : ""}';
	};

	/**
	 * Formatting function used for enum instance `Module(m)`.
	 * Can be replaced with any custom function.
	 */
	public static var formatModule = (module:String) -> module;

	/**
	 * Formatting function used for enum instance `FilePos(s, file, line, column)`.
	 * Can be replaced with any custom function.
	 */
	public static var formatFilePos = (s:Null<StackItem>, file:String, line:Int, column:Null<Int>) -> {
		return '${hideFilePath ? "" : file + separator}${format(s)}${separator}${formatLineColumn(line, column)}';
	};

	/**
	 * Formatting function used in `formatMethod()`.
	 * Can be replaced with any custom function.
	 */
	public static var formatClass = (?className:String) -> {
		return className != null ? '${hideModulePath ? className.sliceAfterLastDot() : className}' : "?";
	};

	/**
	 * Formatting function used for enum instance `Method(className, methodName)`.
	 * Can be replaced with any custom function.
	 */
	public static var formatMethod = (?className:String, methodName:String) -> {
		return '${formatClass(className)}::${methodName}';
	};

	/**
	 * Formatting function used for enum instance `LocalFunction(v)`.
	 * Can be replaced with any custom function.
	 */
	public static var formatLocalFunction = (v:Null<Int>) -> 'fn ${v}';
}