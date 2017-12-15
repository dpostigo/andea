//
// Created by Daniela Postigo on 12/14/17.
//

import Foundation

public enum Lorem {
    
    static let minSentence = 4
    static let maxSentence = 16

    public static func sentences( _ count: Int = 1) -> String {
	    let sentences = (0 ..< count).map({ _ in self.string(Int.random(self.minSentence, self.maxSentence)).capitalizedFirst + "." })
	    return sentences.joined(separator: " ")
    }


	public static func string(_ count: Int = 1) -> String {
		return self.words(count).joined(separator: " ")
	}

	public static func words(_ count: Int = 1) -> [String] {
		return Array(self.words[0 ..< count])
	}

	public static var word: String {
		return self.words[Int.random(0, self.words.count - 1)]
	}

	private static var words: [String] {
		let words = "alias consequatur aut perferendis sit voluptatem accusantium doloremque aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis nemo enim ipsam voluptatem quia voluptas sit suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae et iusto odio dignissimos ducimus qui blanditiis praesentium laudantium totam rem voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident sed ut perspiciatis unde omnis iste natus error similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo porro quisquam est qui minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores doloribus asperiores repellat"
		return words.components(separatedBy: " ")
	}
}


extension Int {

	public static func random(_ start: Int = 0, _ end: Int) -> Int {
		var a = start
		var b = end
		if a > b { swap(&a, &b) } // swap to prevent negative integer crashes
		return Int(arc4random_uniform(UInt32(b - a + 1))) + a
	}
}