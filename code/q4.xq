declare namespace functx = "http://www.functx.com";
declare function functx:sequence-deep-equal
  ( $seq1 as item()* ,
    $seq2 as item()* )  as xs:boolean {

  every $i in 1 to max((count($seq1),count($seq2)))
  satisfies deep-equal($seq1[$i],$seq2[$i])
 } ;
<pairs> {
	let $users := doc("users.xml")//user
	let $five_or_more :=		
		for $user in $users
		where count($user//playlist) > 4
		return $user
	for $user1 in $five_or_more
	for $user2 in $five_or_more
	where ($user1/@uid < $user2/@uid) and not except({$user1//@pid}, {$user2//@pid}) and not except ({$user2//@pid}, {$user1//@pid})
	return <pair uid1="{$user1/@uid}" uid2="{$user2/@uid}"/>
} </pairs>