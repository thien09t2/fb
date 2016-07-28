﻿-- Function: getallownimage(integer, integer, integer, integer)

-- DROP FUNCTION getallownimage(integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION getallownimage(
    IN in_userid integer,
    IN in_orderby integer,
    IN in_pagenumber integer,
    IN in_pagesize integer)
  RETURNS TABLE(imageid integer, competitionname character varying, "competitionId" integer, uploadtime timestamp without time zone, point integer, imageurl character varying, lng character varying, lat character varying, locationname character varying, speciesid integer, description text, userid integer, "Firstname" character varying, avatarurl character varying, "commentNum" bigint) AS
$BODY$
BEGIN
	CASE WHEN in_orderBy = 1 THEN 
		RETURN QUERY SELECT "ImageId", "CompetitionName", fb_image_info."CompetitionId", "UploadTime", "Point",
					"ImageUrl","Lng", "Lat", "LocationName", "SpeciesId",
					fb_image_info."Description", fb_user."UserId", fb_user."FirstName",
					fb_user."AvatarUrl",  (SELECT "count"(*) FROM fb_comment WHERE fb_comment."ImageId" = fb_image_info."ImageId") AS commentNumber
					FROM fb_image_info
					JOIN fb_competition ON fb_competition."CompetitionId" = fb_image_info."CompetitionId"
					JOIN fb_user ON fb_user."UserId" = fb_image_info."UserId"
					WHERE fb_image_info."UserId" = in_userId
					ORDER BY "UploadTime" DESC
					LIMIT in_pageSize OFFSET in_pagenumber*in_pageSize;
	WHEN in_orderBy = 2 THEN
		RETURN QUERY SELECT "ImageId", "CompetitionName", fb_image_info."CompetitionId", "UploadTime", "Point",
					"ImageUrl","Lng", "Lat", "LocationName", "SpeciesId",
					fb_image_info."Description", fb_user."UserId", fb_user."FirstName",
					fb_user."AvatarUrl",  (SELECT "count"(*) FROM fb_comment WHERE fb_comment."ImageId" = fb_image_info."ImageId") AS commentNumber
					FROM fb_image_info
					JOIN fb_competition ON fb_competition."CompetitionId" = fb_image_info."CompetitionId"
					JOIN fb_user ON fb_user."UserId" = fb_image_info."UserId"
					WHERE fb_image_info."UserId" = in_userId 
					ORDER BY "LocationName" DESC
					LIMIT in_pageSize OFFSET in_pagenumber*in_pageSize;
	WHEN in_orderBy = 3 THEN
		RETURN QUERY SELECT "ImageId", "CompetitionName", fb_image_info."CompetitionId", "UploadTime", "Point",
					"ImageUrl","Lng", "Lat", "LocationName", "SpeciesId",
					fb_image_info."Description", fb_user."UserId", fb_user."FirstName",
					fb_user."AvatarUrl",  (SELECT "count"(*) FROM fb_comment WHERE fb_comment."ImageId" = fb_image_info."ImageId") AS commentNumber
					FROM fb_image_info
					JOIN fb_competition ON fb_competition."CompetitionId" = fb_image_info."CompetitionId"
					JOIN fb_user ON fb_user."UserId" = fb_image_info."UserId"
					WHERE fb_image_info."UserId" = in_userId 
					ORDER BY "SpeciesId" DESC
					LIMIT in_pageSize OFFSET in_pagenumber*in_pageSize;

	ELSE
		RETURN QUERY SELECT "ImageId", "CompetitionName", fb_image_info."CompetitionId", "UploadTime", "Point",
					"ImageUrl","Lng", "Lat", "LocationName", "SpeciesId",
					fb_image_info."Description", fb_user."UserId", fb_user."FirstName",
					fb_user."AvatarUrl",  (SELECT "count"(*) FROM fb_comment WHERE fb_comment."ImageId" = fb_image_info."ImageId") AS commentNumber
					FROM fb_image_info
					JOIN fb_competition ON fb_competition."CompetitionId" = fb_image_info."CompetitionId"
					JOIN fb_user ON fb_user."UserId" = fb_image_info."UserId"
					WHERE fb_image_info."UserId" = in_userId 
					ORDER BY "Point" DESC
					LIMIT in_pageSize OFFSET in_pagenumber*in_pageSize;
	END CASE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION getallownimage(integer, integer, integer, integer)
  OWNER TO postgres;
