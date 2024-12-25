// src/item/dto/create-item.dto.ts
import { IsString, IsNotEmpty, IsNumber, Min, IsOptional } from 'class-validator';

export class CreateItemDto {

  @IsString()
  @IsNotEmpty()
  title: string;  // アイテムの説明

  @IsNumber()
  description: string;  // アイテムの価格

  @IsString()
  @IsNotEmpty()
  status: string;  // アイテムのカテゴリー
}
