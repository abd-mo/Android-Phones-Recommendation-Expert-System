


(deffunction ask-question (?qBEG ?qMID ?qEND $?allowed-values)
	(printout t ?qBEG ?qMID ?qEND)
	(bind ?answer (read))
	(if (lexemep ?answer)
		then (bind ?answer (lowcase ?answer))
	)
	(while (not (member ?answer ?allowed-values)) do
		(printout t ?qBEG ?qMID ?qEND)
		(bind ?answer (read))
		(if (lexemep ?answer)
			then (bind ?answer (lowcase ?answer)))
	)
?answer)


(defrule ask-price
	
        (initial-fact)
	=>
   (printout t "----------------------------------------------------" crlf)
   (printout t "----------------------------------------------------" crlf)
   (printout t "Welcome to Andriod Mobiles Suggestion Expert system" crlf)
   (printout t "---------------------------------------------------" crlf)
   (printout t "---------------------------------------------------" crlf)

	
	(bind ?price (ask-question crlf "What is Your Money Budget? (low,medium,high):" "" ""low medium high))
	(assert (thePrice ?price))	
)



(defrule apply-price
	(thePrice ?p)
	?ani <- (mobile (price ?price))
	=>
	(if (eq ?p low)
		then (if (>= ?price 200) then  (retract ?ani))
	else (if (eq ?p medium)
		    then (if (or (<= ?price 200) (>= ?price 500)) then (retract ?ani))
		 )
	else (if (eq ?p high)
		    then (if (< ?price 500)then (retract ?ani) )
		 )
	)
)

(defrule ask-screen-size
	
        (thePrice ?p)
	=>
	(bind ?screensize (ask-question crlf crlf "Which size you prefer (normal & big ) :" "" "" normal big ))
	(assert (theScreenSize ?screensize))	
)


(defrule apply-screen-size
	(theScreenSize ?s)
	?ani <- (mobile (screensize ?screensize))
	=>
	(if (eq ?s normal)
		then (if (>= ?screensize 6.2) then  (retract ?ani))
	
	else (if (eq ?s big)
		    then (if (< ?screensize 6.2)then (retract ?ani))
		 )
	)
)





(defrule list-brand
(theScreenSize ?s)
(mobile (brand ?brand) )

   =>

(printout t "" crlf "available brand option :   "?brand   )

)


(defrule brand-rule
	
(theScreenSize ?s)
	=>
       (printout t crlf crlf "Choose your brand from the options above : ")
       (bind ?brand (read))
       (assert (theBrand ?brand))
		
)

(defrule apply-brand-rule
	(theBrand ?b)
	?ani <- (mobile (brand $?brand))
	=>
	(if (not (member$ ?b $?brand))
		then (retract ?ani)
	)
)


(defrule list-ram
(theBrand ?b)
(mobile (ram ?ram) )

   =>

(printout t "" crlf "available ram option :   "?ram  )

)


(defrule ram
    (theBrand ?b)
	=>
         
	 (bind ?ram (ask-question crlf crlf "Choose your ram size from the options above : " "" "" 1 2 3 4 6 8 12 16))
          (assert (theRam ?ram))
		
	
)

(defrule apply-ram
	(theRam ?r)
	?ani <- (mobile (ram $?ram))
	=>
	(if (not (member$ ?r $?ram))
		then (retract ?ani)
	)
)


(defrule list-storage
(theRam ?r)
(mobile (storage ?storage) )

   =>

(printout t "" crlf "available storage option :   "?storage  )

)

(defrule storage
    (theRam ?r)
	=>
         
	 (bind ?storage (ask-question crlf crlf "Choose your storage  from the options above : " "" "" 32 64 128 256 512))
          (assert (theStorage ?storage))
		
	
)


(defrule apply-storage
	(theStorage ?t)
	?ani <- (mobile (storage $?storage))
	=>
	(if (not (member$ ?t $?storage))
		then (retract ?ani)
	)
)


(defrule list-main-camera
(theStorage ?t)
(mobile (bcamera ?bcamera) )

   =>

(printout t "" crlf "available main camera option :   "?bcamera  )

)

(defrule main-camera
    (theStorage ?t)
	=>
         
	 (bind ?bcamera (ask-question crlf crlf "Choose your Main Camera Quality from the options above : " "" "" 108 44 12 64 48 16 25 13 50))
          (assert (thebcamera ?bcamera))
		
	
)


(defrule apply-main-camera
	(thebcamera ?b)
	?ani <- (mobile (bcamera $?bcamera))
	=>
	(if (not (member$ ?b $?bcamera))
		then (retract ?ani) 
	)
)

(defrule list-selfi-camera
(thebcamera ?b)
(mobile (fcamera ?fcamera) )

   =>

(printout t "" crlf "available front camera option :   "?fcamera  )

)

(defrule selfi-camera
    (thebcamera ?b)
	=>
         
	 (bind ?fcamera (ask-question crlf crlf "Choose your Front Quality from the options above : " "" "" 10 12 48 16 25 13 5 8 32 20 40 44))
          (assert (thefcamera ?fcamera))
		
	
)


(defrule apply-selfi-camera
	(thefcamera ?q)
	?ani <- (mobile (fcamera $?fcamera))
	=>
	(if (not (member$ ?q $?fcamera))
		then (retract ?ani)
	)
)


(defrule print-result
?f <- (thefcamera ?q)
(mobile (name ?sn) (brand ?si) (price ?m) (ram ?n)(battery ?b)(cpu ?cpu)(screenresolution ?screenresolution)(screentechnology ?screentechnology)(connection ?connection))


   =>
(retract ?f)
(printout t crlf "<---------------------The Suggested phone--------------------->" crlf crlf "---Name :"?sn crlf "---Brand :" ?si crlf "---price: " ?m crlf "---Ram Size:" ?n crlf "---Screen Technology:" ?screentechnology  crlf "---Connection:" ?connection  crlf "---Screen Resolution:" ?screenresolution crlf "---Battery:" ?b crlf crlf)
)