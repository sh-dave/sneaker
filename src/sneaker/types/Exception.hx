package sneaker.types;

import sneaker.format.CallStackItemExtension;
import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.PosInfos;

/**
 * Base exception class.
 */
@:nullSafety(Strict)
class Exception {
	public static var appendCallStack = true;

	public final content:Dynamic;
	public final callStack:Array<StackItem>;
	public final positionInformation:Null<PosInfos>;

	public function new(content:Dynamic, ?callStack:Array<StackItem>, ?pos:PosInfos) {
		this.content = content;

		if (callStack != null) {
			this.callStack = callStack;
		} else if (appendCallStack) {
			final currentCallStack = CallStack.callStack();
			currentCallStack.shift();
			this.callStack = currentCallStack;
		} else {
			this.callStack = [];
		}

		this.positionInformation = pos;
	}

	public function toString():String {
		if (appendCallStack)
			return '${content}\n\nCall Stack:\n${callStack.map(CallStackItemExtension.format).join("\n")}';
		else
			return content;
	}
}
