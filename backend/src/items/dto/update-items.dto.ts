// src/item/dto/update-item.dto.ts
import { IsString, IsOptional, IsNumber, Min } from 'class-validator';

export class UpdateItemDto {

  @IsString()
  @IsOptional()
  title?: string;  // アイテムの説明（任意）

  @IsNumber()
  @IsOptional()
  description?: string;  // アイテムの価格（任意）

  @IsString()
  @IsOptional()
  status?: string;  // アイテムのカテゴリー（任意）
}
