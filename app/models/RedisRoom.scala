package models

import play.api.libs.iteratee.Concurrent
import play.api.libs.iteratee.Iteratee
import play.api.libs.concurrent.Execution.Implicits.defaultContext

import flect.redis.RedisService
import flect.redis.Room
import flect.websocket.CommandResponse
import flect.websocket.CommandHandler
import flect.websocket.CommandBroadcast

class RedisRoom(val roomInfo: RoomInfo, redis: RedisService) extends Room("room." + roomInfo.id, redis) with CommandBroadcast {

  val roomId = roomInfo.id

  lazy val eventManager = EventManager(roomId, this)
  lazy val questionManager = QuestionManager(roomId, this)

  val commandOut = {
    val (cout, cchannel) = Concurrent.broadcast[CommandResponse]
    val i = Iteratee.foreach[String] { msg =>
      val res = CommandResponse.fromJson(msg)
      cchannel.push(res)
    }
    channel.out(i)
    cout
  }

  private def doIncMember(n: Int) = {
    redis.hincrby("room-member", roomId.toString, n).map { ret =>
      send(new CommandResponse("member", ret.toString))
      ret.toInt
    }.getOrElse(0)
  }
  def member: Int = redis.hget("room-member", roomId.toString).getOrElse("0").toInt
  def incMember: Int = doIncMember(1)
  def decMember: Int = doIncMember(-1)

  def send(msg: CommandResponse) = channel.send(msg.toString)

  val memberCommand = CommandHandler { command =>
    val ret = member
    command.text(ret.toString)
  }

}