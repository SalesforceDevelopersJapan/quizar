package models

import play.api.libs.json._
import scalikejdbc._
import scalikejdbc.SQLInterpolation._
import org.joda.time.DateTime

import models.entities.QuizQuestion
import flect.websocket.Command
import flect.websocket.CommandHandler

class QuestionManager(roomId: Int) {

  private val qq = QuizQuestion.qq
  implicit val autoSession = AutoSession
  
  def countAndPublished: (Int, Int) = {
    withSQL {
      select(sqls"""
        count(*),
        SUM(
          CASE WHEN PUBLISH_COUNT = 0 THEN 0,
          ELSE 1 END
        )""").from(QuizQuestion as qq)
    }.map(rs => (rs.int(1), rs.int(2))).single.apply().get
  }

  def list(published: Boolean, offset: Int, limit: Int): List[QuestionInfo] = {
    withSQL { 
      val cond = published match {
        case true => SQLSyntax.eq(qq.publishCount, 0)
        case false => SQLSyntax.ne(qq.publishCount, 0)
      }
      select
        .from(QuizQuestion as qq)
        .where.eq(qq.roomId, roomId)
        .and.append(cond)
        .orderBy(qq.id).desc.limit(limit).offset(offset)
    }.map(rs => QuizQuestion(qq.resultName)(rs)).list.apply.map(QuestionInfo.create(_))
  }

  def create(q: QuestionInfo): QuestionInfo = {
    val now = new DateTime()
    val entity = QuizQuestion.create(
      roomId=q.roomId,
      createdBy=q.createdBy,
      question=q.question,
      answers=q.answers,
      answerType=q.answerType,
      tags=q.tags,
      description=q.description,
      relatedUrl=q.relatedUrl,
      publishCount=q.publishCount,
      correctCount=q.correctCount,
      wrongCount=q.wrongCount,
      created=now,
      updated=now
    )
    QuestionInfo.create(entity)
  }

  def update(q: QuestionInfo): Boolean = {
    val now = new DateTime()
    QuizQuestion.find(q.id).map { entity =>
      entity.copy(
        question=q.question,
        answers=q.answers,
        answerType=q.answerType,
        tags=q.tags,
        description=q.description,
        relatedUrl=q.relatedUrl,
        updated=now
      ).save();
      true;
    }.getOrElse(false)

  }

  def publish(id: Int) = {

  }

  def updateAnswers(id: Int, correct: Int, wrong: Int) = {

  }
  
  val createCommand = CommandHandler { command =>
    val q = create(QuestionInfo.fromJson(command.data))
    command.json(q.toJson)
  }

  val listCommand = CommandHandler { command =>
    val published = (command.data \ "published").as[Boolean]
    val offset = (command.data \ "offset").as[Int]
    val limit = (command.data \ "limit").as[Int]
    val data = list(published, offset, limit).map(_.toJson)
    command.json(JsArray(data))
  }

  val countCommand = CommandHandler { command =>
    val (count, published) = countAndPublished
    command.json(JsObject(Seq(
      "count" -> JsNumber(count),
      "published" -> JsNumber(published)
    )))
  }
}
