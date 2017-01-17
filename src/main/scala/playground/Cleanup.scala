package com.datascienceretreat.ubuntubot

object Cleanup extends App {

  type Token = String
  type Utterance = Seq[Token]
  type Dialogue = (Seq[Utterance], Utterance, Boolean)

  // Ubuntu corpus v1
  lazy val regex = "^(\".+\"|.+),(\".+\"|.+),([01])$".r
  //lazy val regex = "(\".+\"|.+),([01])$".r

  // Build a single dialogue from a line of the Ubuntu corpus dataset (v1)
  def clean(line: String): Dialogue = line match {
    case regex(field1, field2, field3) =>

      // Break the context first into utterances, then tokens

      
      val context = field1
        .stripMargin('"').replaceAll("\"\"", "\"")
        .split(" </s> ").toSeq.map(_.split("[^a-zA-Z0-9]").toSeq) // TODO: more intelligent tokenization

      val statement = field2
        .stripMargin('"').replaceAll("\"\"", "\"")
        .split("[\\s,]+").toSeq

      val appropriate = (field3.toInt == 1)


      (context, statement, appropriate)
  }


  def rebuild(dialogue: Dialogue): String = {
    val cat = dialogue._1.mkString(" </s> ")
    val field1 = if (cat contains ",") "\"" + cat + "\"" else cat
    val field2 = if (dialogue._2 contains ",") "\"" + dialogue._2 + "\"" else dialogue._2
    val field3 = if (dialogue._3) 1 else 0

    List(field1, field2, field3).mkString(",")
  }

}
