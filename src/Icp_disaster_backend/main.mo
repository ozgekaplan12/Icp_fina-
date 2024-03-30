import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Bool "mo:base/Bool";

actor {

  public shared (msg) func whoami() : async Principal {
    msg.caller;
  };

  type Post = {
    author : Principal;
    content : Text;
  };

  func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  var posts = Map.HashMap<Nat, Post>(0, Nat.equal, natHash);
  var nextId : Nat = 0;

  public shared (msg) func addPost(content : Text) : async Nat {
    let id = nextId;
    posts.put(id, { author = msg.caller; content = content });
    nextId += 1;
    id;
  };

  public query func getPosts() : async [Post] {
    Iter.toArray(posts.vals());
  };

  public type AfetBildirimlerId = Nat32;

  public type Afetbildirim = {
    disasterType : List.List<Text>;
    disasterLocation : List.List<Text>;
    disasterTime : Nat32;
    description: Text;
    details: List.List<Text>;
    siddet : Nat32;
    aciliyet : Bool;
  };

  private stable var next: AfetBildirimlerId = 0;

  private stable var afetbildirimleri: Trie.Trie<AfetBildirimlerId, Afetbildirim> = Trie.empty();



  public func addAfetBildirimi(afetbildirim: Afetbildirim) : async AfetBildirimlerId {
    let AfetBildirimlerId = next;
    next += 1;
     afetbildirimleri := Trie.replace(
      afetbildirimleri,
      key(AfetBildirimlerId),
      Nat32.equal,
      ?afetbildirim,
    ).0;
    AfetBildirimlerId
  };


  public query func read(afetBildirimlerId: AfetBildirimlerId) : async ?Afetbildirim {
    let result = Trie.find(afetbildirimleri, key(afetBildirimlerId), Nat32.equal);
     result
   };

   public func update(afetBildirimlerId: AfetBildirimlerId, afetbildirim: Afetbildirim) : async Bool {
    let result = Trie.find(afetbildirimleri, key(afetBildirimlerId), Nat32.equal);
    let exists = Option.isSome(result);
    if(exists){
      afetbildirimleri := Trie.replace(
        afetbildirimleri,
        key(afetBildirimlerId),
        Nat32.equal,
        ?afetbildirim,
      ).0;
    };
    exists
    };
  

   public func delete(afetBildirimlerId: AfetBildirimlerId): async Bool {
    let result = Trie.find(afetbildirimleri, key(afetBildirimlerId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      afetbildirimleri := Trie.replace(
        afetbildirimleri,
        key(afetBildirimlerId),
        Nat32.equal,
        null,

      ).0;
    };
    exists
  };

  private func key (x: AfetBildirimlerId): Trie.Key<AfetBildirimlerId>{
    { hash = x; key = x };
  };

  public type AfetYardimId = Nat32;

  public type AfetYardim = {
    ihtiyaclar: List.List<Text>;
    description1: Text;
    miktar1: Nat32;
    aciliyet1: Text;
    konum1: List.List<Text>;
    bildirim1: Text;
  };

  private stable var next1: AfetYardimId = 0;


  private stable var afetyardimlari: Trie.Trie<AfetYardimId, AfetYardim> = Trie.empty();

  public func addAfetYardimTalep(afetyardim: AfetYardim) : async AfetYardimId {
    let afetYardimId = next;
    next1 += 1;
     afetyardimlari := Trie.replace(
      afetyardimlari,
      key1(afetYardimId),
      Nat32.equal,
      ?afetyardim,
    ).0;
    afetYardimId
  };

  private func key1 (x: AfetYardimId): Trie.Key<AfetYardimId>{
    { hash = x; key = x };
  };

  public type GonulluKaydiId = Nat32;

  public type GonulluKaydi = {
    tecrube: Text;
    konum : List.List<Text>;
    
  };

  private stable var next2: GonulluKaydiId = 0;

  private stable var gonullukayitlari: Trie.Trie<GonulluKaydiId, GonulluKaydi> = Trie.empty();

  public func addGonulluKaydi(gonullukaydi: GonulluKaydi) : async GonulluKaydiId {
    let gonullukaydiId = next;
    next2 += 1;
     gonullukayitlari := Trie.replace(
      gonullukayitlari,
      key2(gonullukaydiId),
      Nat32.equal,
      ?gonullukaydi,
    ).0;
    gonullukaydiId
  };

  private func key2 (x: AfetYardimId): Trie.Key<AfetYardimId>{
    { hash = x; key = x };
  };


};




