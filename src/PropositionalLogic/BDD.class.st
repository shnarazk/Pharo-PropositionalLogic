"
Binary Decision Diagram

Bryant, Randal E., _Graph-Based Algorithms for Boolean Function Manipulation_ [PDF](https://apps.dtic.mil/sti/pdfs/ADA470446.pdf). IEEE Transactions on Computers. C-35 (8): 677–691. CiteSeerX 10.1.1.476.2952. doi:10.1109/TC.1986.1676819. S2CID 10385726.  August 1986.

- https://apps.dtic.mil/sti/pdfs/ADA470446.pdf
"
Class {
	#name : 'BDD',
	#superclass : 'DD',
	#category : 'PropositionalLogic',
	#package : 'PropositionalLogic'
}

{ #category : 'algorithm' }
BDD >> apply: other [

	self notYetImplemented

	"
	fn apply(v1: vertex, v2: vertex; op: Operator) -> vertex {
	  // Recursive routine to implement Apply
	  fn apply_step(mut T: Array<vertex>, v1: vertex; v2: vertex, op: Operator) -> vertex {
	    let mut u = T[v1.id, v2.id];
	    if u != null { return u; }    // have already evaluated
	    u = vertex::new();
	    u.mark = false;
	    T[v1.id, v2.id] = v1.value op v2.value;
	    if u.value != X {
	      // create terminal vervex
	      u.index = n + 1;
	      u.low = null; u.high = null;
	    } else {
	      u.inddex = v1.index.min(v2.index);
	      if v1.index == u.index { vlow1 = v1.low; vhigh1 = v1.hight;  } else {   vlow1 = v1; vhigh1 = v1; }
	      if v2.index == u.index {  vlow2 = v2.low; vhigh2 = v2.hight;  } else {   vlow2 = v2; vhigh2 = v2; }
	      u.low = apply_step(T, vlow1, vlow2, op);
	      u.high = apply_step(T, vhigh1, vhigh2, op);
	    }
	    u
	  }
	  let mut T: Array<vertex>[1..|G1|, 1..|G2|];
	  initialize all elements of T to null;
	  reduce(apply_step(T, v1, v2, op))
	}
	"
]

{ #category : 'algorithm' }
BDD >> compose:  x1 and: x2 [

	self notYetImplemented
]

{ #category : 'initialization' }
BDD >> normalize [

	self notYetImplemented
]

{ #category : 'algorithm' }
BDD >> reduce [

	self notYetImplemented

	"
	fn reduce(v: vertex) -> vertex {
		let mut subgraph: array<vertex>[1..|G|];
		let mut vlist: array<list>[1..n+1];
		put each vertex u on list vlist[u.index];
		let mut nextid = 0;
		for i in (1..=n+1).rev() {
			let mut Q = empty set;
			for each in vllist[i] {
				if u.index == n + 1 {
					add <key, u> to Q where key = (u.value); // terminal vertex
				} else if u.low.id == u.high.id {
					u.id = u.low.id // redundant vertex
				} else {
					add <key, u> to Q where key = (u.low.id, u.high.id);
				}
			}
			Q.sort(); // sort elements of Q by keys;
			let mut oldkey = (-1, -1);     // unmatchable key
			for <key, u> in Q removed in order do {  // while let Some((key, u)) = Q.pop() {  }
				if key == oldkey {
					u.id = nextid;     // matches existing vertex
				} else {             // unique vertex
					nextid = nextid + 1; u.id = nextid; subgraph[nextidd] = u; u.low = subgraph[u.low.id]; u.high = subgraph[u.high.id]; oldkey = key;
				}
			}
		}
		subgraph[v.id]
	}
	"
]

{ #category : 'algorithm' }
BDD >> restrict: varIndex [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyAll [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyCount [

	self notYetImplemented
]

{ #category : 'evaluating' }
BDD >> satisfyOne [

	self notYetImplemented
]
